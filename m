Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44987C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E40217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ekrSqcDt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HvJrHxw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCMGWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:22:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCMGWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:22:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F1C2E6013C; Wed, 13 Mar 2019 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552458170;
        bh=Qk+Z5ACV1mraTrKfNiMq5DAl1EJzJyhwZ3WaL530rWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ekrSqcDtHbP3q9oPRowtkYWsEzUXQhxgbPEKsaO/S4tE/hun0LPuTtzxGsmhxvSxU
         m6baZ07XctenbqRnM7+nZyLYumM1U0S1qXM+bmzNl9S0+SM64IOyPSdaAQ4ZKoWzFb
         XUTyDPTS0uGfEivOajsH/bMicYLT8A99SsMwYbNY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0923160312;
        Wed, 13 Mar 2019 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552458169;
        bh=Qk+Z5ACV1mraTrKfNiMq5DAl1EJzJyhwZ3WaL530rWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvJrHxw8MezoWc7Bn0DNglNW8fXLeTaDo5g2ksybk6QXS2Djc5OfvhXnlft+fkYMh
         0qMrNCSVrTsY9x32ZDfQglGDIbdQWBCDsqNOE3OD0zmE1N3sfizenqtOhK6HCd/u74
         Qw8FihCVNiHG7fP7dKVhJ0h0es0wAZHl/oUXs3K8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Mar 2019 11:52:49 +0530
From:   c-hbandi@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Added support for wcn3998
In-Reply-To: <20190312162947.GC200579@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-2-git-send-email-c-hbandi@codeaurora.org>
 <20190312162947.GC200579@google.com>
Message-ID: <07ea88c528429dba6178a4ea515628ec@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,



On 2019-03-12 21:59, Matthias Kaehlcke wrote:
> Hi Harish,
> 
> On Tue, Mar 12, 2019 at 05:52:58PM +0530, Harish Bandi wrote:
>> Added new compatible for wcn3998 and corresponding voltage
>> and current values to wcn3998 compatible.
>> Changed driver code to support wcn3998
>> 
>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> ---
>> changes in v3:
>> - updated to latest code base.
> 
> This is not useful, for future versions please describe what changed
> (e.g. 'specify regulator constraints in the driver instead of the DT')
> 

[Harish] --  added details in v2, and v3 uploaded just to rebase on tip 
of bluetooth-next
for better understanding of code in review. From new patch onwards will 
add all patch
version changes and add proper description.

>> ---
>>  drivers/bluetooth/btqca.c   |  4 ++--
>>  drivers/bluetooth/btqca.h   |  3 ++-
>>  drivers/bluetooth/hci_qca.c | 40 
>> ++++++++++++++++++++++++++--------------
>>  3 files changed, 30 insertions(+), 17 deletions(-)
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
> That works, but isn't super-clear and might need to be adapted when
> future non-WCN399x controllers are added.
> 
> Some possible alternatives:
> 
> - is_wcn399x(soc_type)
> - have a family (Rome, Cherokee (IIRC this name was used for WCN3990))
>   and a chip id (QCA6174, WCN3990, WCN3998, ...)
> 

[Harish] -- Will change like is_wcn399x(soc_type) and come up with new 
patch

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
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/crnv%02x.bin", rom_ver);
>>  	else
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index c72c56e..f03d96e 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -132,7 +132,8 @@ enum qca_btsoc_type {
>>  	QCA_INVALID = -1,
>>  	QCA_AR3002,
>>  	QCA_ROME,
>> -	QCA_WCN3990
>> +	QCA_WCN3990,
>> +	QCA_WCN3998
> 
> nit: if you add a comma after the last value the line doesn't need to
> be changed when a new type is added in the future.
> 
[Harish] -- will take care in new patch

> Is 'WCN3998' specific enough? You mentioned earlier that there are
> multiple WCN3998 variants with different requirements for regulator
> voltages/max currents. Which names does Qualcomm use to distinguish
> between them (e.g. WCN3998-A, WCN3998-B, ...)?

[Harish] -- for now we want to add WCN3998 support only, What i mean to 
say in my earlier
explanation that. WCN3990 is base variant and on top of that we have 
variants like WCN3990,
WCN3998 and WCN3998-0,WCN3998-1 like that..

> 
> Thanks
> 
> Matthias

Thanks,
Harish
