Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A02C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9EB271AF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfFCSAf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:00:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:31358 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFCSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:00:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 11:00:34 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2019 11:00:34 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Jun 2019 11:00:34 -0700
Received: from hasmsx114.ger.corp.intel.com (10.184.198.65) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Jun 2019 11:00:33 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.66]) by
 HASMSX114.ger.corp.intel.com ([169.254.14.203]) with mapi id 14.03.0415.000;
 Mon, 3 Jun 2019 21:00:31 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [RFC PATCH 36/57] drivers: mei: Use class_find_device_by_devt
 match helper
Thread-Topic: [RFC PATCH 36/57] drivers: mei: Use class_find_device_by_devt
 match helper
Thread-Index: AQHVGiRM/z8BqVnv+kKKGRNhs5xXkaaKN3cQ
Date:   Mon, 3 Jun 2019 18:00:30 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DC23236@hasmsx108.ger.corp.intel.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-37-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-37-git-send-email-suzuki.poulose@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Suzuki K Poulose [mailto:suzuki.poulose@arm.com]
> Sent: Monday, June 03, 2019 18:50
> To: linux-kernel@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; rafael@kernel.org; suzuki.poulose@arm.com;
> Winkler, Tomas <tomas.winkler@intel.com>; Arnd Bergmann
> <arnd@arndb.de>
> Subject: [RFC PATCH 36/57] drivers: mei: Use class_find_device_by_devt match
> helper
> 
> Switch to the generic helper class_find_device_by_devt.

Looks okay, but  you could add me at least to cover later mail, there is very little context. 


Thanks
Tomas


> 
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/misc/mei/main.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
> ad02097..243b481 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -858,13 +858,6 @@ static ssize_t dev_state_show(struct device *device,  }
> static DEVICE_ATTR_RO(dev_state);
> 
> -static int match_devt(struct device *dev, const void *data) -{
> -	const dev_t *devt = data;
> -
> -	return dev->devt == *devt;
> -}
> -
>  /**
>   * dev_set_devstate: set to new device state and notify sysfs file.
>   *
> @@ -880,7 +873,7 @@ void mei_set_devstate(struct mei_device *dev, enum
> mei_dev_state state)
> 
>  	dev->dev_state = state;
> 
> -	clsdev = class_find_device(mei_class, NULL, &dev->cdev.dev,
> match_devt);
> +	clsdev = class_find_device_by_devt(mei_class, NULL, dev->cdev.dev);
>  	if (clsdev) {
>  		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
>  		put_device(clsdev);
> --
> 2.7.4

