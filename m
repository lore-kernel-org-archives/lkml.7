Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648820830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WwZriKzy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NPJnhjzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfCZJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:53:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:53:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E99F60D0C; Tue, 26 Mar 2019 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553593996;
        bh=HLyAvWmig/Z5kRrO6j6rDpOhNiTXq3WTDyuRB1x8+jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WwZriKzy8K18VkFLs2EWHDia/R1SmWjNyrnVjWcoJNwhI6C1V82P8kxpo14sL40vY
         3Zk9h7hftPYdsDbcKFBfnqDVpUEQgGUXg/vm6Pfi1UUTHgkzzQpqy2p6NuEaG86Kmq
         i8RsS5xznnl8lUTe0tM3PgBglH4H6AAGIhidGMA4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D1DB7608CC;
        Tue, 26 Mar 2019 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553593994;
        bh=HLyAvWmig/Z5kRrO6j6rDpOhNiTXq3WTDyuRB1x8+jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NPJnhjzJxDrOiwCb8R8bubV0XYg5hq5Ho3qVZ8lgkBhp6ZrF7ue/fxu1knIcB3GFF
         fxNObpZFxuVqht3r2bnI5tNsW/ezu3ApHUh/z99k+i3aYk6GeS/V9XLSA2NVplb17L
         pAvFnN7CvxVsVJJ1mb8hgn29Z7fHV8ffHIufrup0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Mar 2019 15:23:14 +0530
From:   c-hbandi@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_qca: Added support for WCN3998
In-Reply-To: <20190325162118.GV112750@google.com>
References: <1553513800-27611-1-git-send-email-c-hbandi@codeaurora.org>
 <1553513800-27611-2-git-send-email-c-hbandi@codeaurora.org>
 <20190325162118.GV112750@google.com>
Message-ID: <b04e4bb2fa6904e593e6bfaa90992a69@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-25 21:51, Matthias Kaehlcke wrote:
> On Mon, Mar 25, 2019 at 05:06:39PM +0530, Harish Bandi wrote:
>> Added new compatible for WCN3998 and corresponding voltage
>> and current values to WCN3998 compatible.
>> Changed driver code to support WCN3998
>> 
>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> ---
>> Changes in V4:
>> - Added is_qca_soc_type_wcn399x_family helper function
>> - to get the soc type is wcn399x or not.
>> ---
>>  drivers/bluetooth/btqca.c   |  4 ++--
>>  drivers/bluetooth/btqca.h   |  3 ++-
>>  drivers/bluetooth/hci_qca.c | 48 
>> ++++++++++++++++++++++++++++++++-------------
>>  3 files changed, 38 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 6122685..70cab13 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -344,7 +344,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>> 
>>  	/* Download rampatch file */
>>  	config.type = TLV_TYPE_PATCH;
>> -	if (soc_type == QCA_WCN3990) {
>> +	if (soc_type >= QCA_WCN3990) {
> 
> Move qca_is_wcn399x() to btqca.c and use it here. Export the symbol
> and declare the function in btqca.h, so it can be used in hci_qca.c
[Harish] - ok, will update in new patch
> 
>>  		/* Firmware files to download are based on ROM version.
>>  		 * ROM version is derived from last two bytes of soc_ver.
>>  		 */
>> @@ -365,7 +365,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>> 
>>  	/* Download NVM configuration */
>>  	config.type = TLV_TYPE_NVM;
>> -	if (soc_type == QCA_WCN3990)
>> +	if (soc_type >= QCA_WCN3990)
> 
> use qca_is_wcn399x()
[Harish] - ok, will update in new patch
> 
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/crnv%02x.bin", rom_ver);
>>  	else
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index c72c56e..bd6a902 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -132,7 +132,8 @@ enum qca_btsoc_type {
>>  	QCA_INVALID = -1,
>>  	QCA_AR3002,
>>  	QCA_ROME,
>> -	QCA_WCN3990
>> +	QCA_WCN3990,
>> +	QCA_WCN3998,
>>  };
>> 
>>  #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 4ea995d..e238c2b 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -189,6 +189,14 @@ static enum qca_btsoc_type qca_soc_type(struct 
>> hci_uart *hu)
>>  	return soc_type;
>>  }
>> 
>> +bool is_qca_soc_type_wcn399x_family(enum qca_btsoc_type soc_type)
> 
> This long function name doesn't provide much value and degrades
> readability of the code that uses it. A short name like
> qca_is_wcn399x() is clear enough and friendlier to the code reader's
> eyes.
> 
>> +{
>> +	if ((soc_type  == QCA_WCN3990) || (soc_type  == QCA_WCN3998))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  static void __serial_clock_on(struct tty_struct *tty)
>>  {
>>  	/* TODO: Some chipset requires to enable UART clock on client
>> @@ -521,7 +529,7 @@ static int qca_open(struct hci_uart *hu)
>>  	if (hu->serdev) {
>> 
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		if (qcadev->btsoc_type != QCA_WCN3990) {
>> +		if (!is_qca_soc_type_wcn399x_family(qcadev->btsoc_type)) {
>>  			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>>  		} else {
>>  			hu->init_speed = qcadev->init_speed;
>> @@ -627,7 +635,7 @@ static int qca_close(struct hci_uart *hu)
>> 
>>  	if (hu->serdev) {
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		if (qcadev->btsoc_type == QCA_WCN3990)
>> +		if (is_qca_soc_type_wcn399x_family(qcadev->btsoc_type))
>>  			qca_power_shutdown(hu);
>>  		else
>>  			gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> @@ -1008,7 +1016,7 @@ static int qca_set_baudrate(struct hci_dev 
>> *hdev, uint8_t baudrate)
>>  		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
>> 
>>  	/* Give the controller time to process the request */
>> -	if (qca_soc_type(hu) == QCA_WCN3990)
>> +	if (is_qca_soc_type_wcn399x_family(qca_soc_type(hu)))
>>  		msleep(10);
>>  	else
>>  		msleep(300);
>> @@ -1084,7 +1092,7 @@ static unsigned int qca_get_speed(struct 
>> hci_uart *hu,
>> 
>>  static int qca_check_speeds(struct hci_uart *hu)
>>  {
>> -	if (qca_soc_type(hu) == QCA_WCN3990) {
>> +	if (is_qca_soc_type_wcn399x_family(qca_soc_type(hu)) >= QCA_WCN3990) 
>> {
> 
> Why '>= QCA_WCN3990'?
[Harish] - ok, it should not will check and correct it.
> 
>>  		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>>  		    !qca_get_speed(hu, QCA_OPER_SPEED))
>>  			return -EINVAL;
>> @@ -1116,7 +1124,7 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		/* Disable flow control for wcn3990 to deassert RTS while
>>  		 * changing the baudrate of chip and host.
>>  		 */
>> -		if (soc_type == QCA_WCN3990)
>> +		if (is_qca_soc_type_wcn399x_family(soc_type))
>>  			hci_uart_set_flow_control(hu, true);
>> 
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>> @@ -1128,7 +1136,7 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		host_set_baudrate(hu, speed);
>> 
>>  error:
>> -		if (soc_type == QCA_WCN3990)
>> +		if (is_qca_soc_type_wcn399x_family(soc_type))
>>  			hci_uart_set_flow_control(hu, false);
>>  	}
>> 
>> @@ -1201,7 +1209,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	/* Patch downloading has to be done without IBS mode */
>>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> 
>> -	if (soc_type == QCA_WCN3990) {
>> +	if (is_qca_soc_type_wcn399x_family(soc_type)) {
>>  		bt_dev_info(hdev, "setting up wcn3990");
>> 
>>  		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
>> @@ -1232,7 +1240,7 @@ static int qca_setup(struct hci_uart *hu)
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>>  	}
>> 
>> -	if (soc_type != QCA_WCN3990) {
>> +	if (!is_qca_soc_type_wcn399x_family(soc_type)) {
>>  		/* Get QCA version information */
>>  		ret = qca_read_soc_version(hdev, &soc_ver);
>>  		if (ret)
>> @@ -1257,7 +1265,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	}
>> 
>>  	/* Setup bdaddr */
>> -	if (soc_type == QCA_WCN3990)
>> +	if (is_qca_soc_type_wcn399x_family(soc_type))
>>  		hu->hdev->set_bdaddr = qca_set_bdaddr;
>>  	else
>>  		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>> @@ -1280,7 +1288,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	.dequeue	= qca_dequeue,
>>  };
>> 
>> -static const struct qca_vreg_data qca_soc_data = {
>> +static const struct qca_vreg_data qca_soc_data_wcn3990 = {
>>  	.soc_type = QCA_WCN3990,
>>  	.vregs = (struct qca_vreg []) {
>>  		{ "vddio",   1800000, 1900000,  15000  },
>> @@ -1291,6 +1299,17 @@ static int qca_setup(struct hci_uart *hu)
>>  	.num_vregs = 4,
>>  };
>> 
>> +static const struct qca_vreg_data qca_soc_data_wcn3998 = {
>> +	.soc_type = QCA_WCN3998,
>> +	.vregs = (struct qca_vreg []) {
>> +		{ "vddio",   1800000, 1900000,  10000  },
>> +		{ "vddxo",   1800000, 1900000,  80000  },
>> +		{ "vddrf",   1300000, 1352000,  300000 },
>> +		{ "vddch0",  3300000, 3300000,  450000 },
>> +	},
>> +	.num_vregs = 4,
>> +};
>> +
>>  static void qca_power_shutdown(struct hci_uart *hu)
>>  {
>>  	struct qca_data *qca = hu->priv;
>> @@ -1424,8 +1443,8 @@ static int qca_serdev_probe(struct serdev_device 
>> *serdev)
>>  	qcadev->serdev_hu.serdev = serdev;
>>  	data = of_device_get_match_data(&serdev->dev);
>>  	serdev_device_set_drvdata(serdev, qcadev);
>> -	if (data && data->soc_type == QCA_WCN3990) {
>> -		qcadev->btsoc_type = QCA_WCN3990;
>> +	if (data && is_qca_soc_type_wcn399x_family(data->soc_type)) {
>> +		qcadev->btsoc_type = data->soc_type;
>>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>>  						sizeof(struct qca_power),
>>  						GFP_KERNEL);
>> @@ -1489,7 +1508,7 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>>  {
>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>> 
>> -	if (qcadev->btsoc_type == QCA_WCN3990)
>> +	if (qcadev->btsoc_type >= QCA_WCN3990)
> 
> use qca_is_wcn399x()
[Harish] - ok, will update in new patch
> 
>>  		qca_power_shutdown(&qcadev->serdev_hu);
>>  	else
>>  		clk_disable_unprepare(qcadev->susclk);
>> @@ -1499,7 +1518,8 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>> 
>>  static const struct of_device_id qca_bluetooth_of_match[] = {
>>  	{ .compatible = "qcom,qca6174-bt" },
>> -	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data},
>> +	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>> +	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

Thanks,
Harish
