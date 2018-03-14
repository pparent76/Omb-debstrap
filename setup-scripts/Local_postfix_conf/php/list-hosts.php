<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<center>
    <table class="table-hover">
        <tr>
            <th class="text-left">Contact domain</th>
            <th class="text-left">tor hidden service</th>
        </tr>
        <?php listHosts(); ?>
    </table>
</center>
</body>
</html>

<?php
/**
 * Return a list of table rows of all onion<->host relationships
 */
function listHosts()
{
    //**************!!!!!!!!!!!!!!!!!!!!!!!!!*************************
    //	Very important: we need to add athentification
    //	Data that are displayed are critical.
    //**************!!!!!!!!!!!!!!!!!!!!!!!!!*************************
    /**
     * @var resource
     */
    $link = null;

    try {
        if (!($link = mysqli_connect('localhost', 'own-mailbox', 'own-mailbox'))) {
            throw new Exception('tls_proxy: Could not connect to MySQL server');
        }

        if (!mysqli_select_db($link, 'postfix')) {
            throw new Exception('Could not select database');
        }

        if (!($reponse = mysqli_query($link, 'SELECT address, transportation FROM transport'))) {
            throw new Exception('Invalid query');
        }

        // On affiche chaque entrée une à une
        while ($donnees = mysqli_fetch_assoc($reponse)) {
            printf(
                '<tr>
                    <td class="text-left">%1$s</td>
                    <td class="text-left">%2$s</td>
                </tr>',
                $donnees['address'],
                substr($donnees['transportation'], 9, -1)
            );
        }
    } catch (Exception $e) {
        printf(
            '<tr>
                <td class="text-left" colspan="2">%1$s<br>%2$s</td>
            </tr>',
            $e->getMessage(),
            $link ? mysqli_error($link) : mysqli_connect_error()
        );
    } finally {
        $link && mysqli_close($link);
    }
}
?>
