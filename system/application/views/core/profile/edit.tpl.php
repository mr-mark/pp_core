<div id="form_container">
    <?php echo form_open('core/profile/edit'); ?>
    <!-- this section is required -->
    <input type="hidden" name="user_id" value="<?= $user->id ?>" />
    <!-- end -->
        <div class="form_description">
            <h2><?= $lang['heading_profile_edit'] ?></h2>
        </div>
        <?php if(isset($message)): ?>
        <div class="error">
            <?= $message ?>
        </div>
        <?php endif; ?>
        <ul >
            <li>
                <label class="description"><?= $lang['label_first_name'] ?></label>
                <div>
                    <input name="first_name" class="element text medium" type="text" maxlength="255" value="<?php echo set_value('first_name', $user->first_name); ?>"/>
                </div>
                <?php echo form_error('first_name', '<div class="error">', '</div>'); ?>
            </li>
            <li>
                <label class="description"><?= $lang['label_last_name'] ?></label>
                <div>
                    <input name="last_name" class="element text medium" type="text" maxlength="255" value="<?php echo set_value('last_name',$user->last_name); ?>"/>
                </div>
                <?php echo form_error('last_name', '<div class="error">', '</div>'); ?>
            </li>
            <!-- load the template of extra field in registration -->
            <?php $this->load->view("core/profile/profileExtraField.tpl.php"); ?>
            <li class="buttons">
                <input id="saveForm" class="button_text" type="submit" name="submit" value="<?= $lang['label_submit'] ?>" />
            </li>
        </ul>
    <div id="footer">
    </div>
</div>