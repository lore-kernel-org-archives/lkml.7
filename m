Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35836C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CDC21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfJ1E6T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 00:58:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41841 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfJ1E6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 00:58:18 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iOx6e-0003jq-Lt
        for linux-kernel@vger.kernel.org; Mon, 28 Oct 2019 04:58:16 +0000
Received: by mail-pg1-f199.google.com with SMTP id l6so7401432pgq.16
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 21:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/EG7yq3okU4wk/5he/oQsCiGYKz5l1BrEDtNp22dINI=;
        b=URa+X2vZYIukWyvxxIJ3Qt92wFW31EUJtTR9w3fBySYoiBrWpuLHGqZJIyJL1mW2+m
         kWnnZIyDf/11B5VqMhKTdWL++QDIWczSV0gfZaBy+uHsUH7XEYs/5EpHIG/nwx9S10JJ
         +wo9tBOBxBl16dO4h0HpUUIGLLpdzI8XZQ0NnNZ2TjYOVL/BIAnGOYXNfSVpuI8EBGfg
         qn2BCC5/Rj0ymlyR3rBRN4jzyVxScw0yCbES+P+GPdfFiQT06K4EQOvAiIirUDsbzVSk
         QTMWyMZGVONJeXtYc2hmeLW41+6BFt5+WO8XZvlvAlMhyUxUra5Wxt0RvSzv/o3/uejS
         ubgg==
X-Gm-Message-State: APjAAAXQr45TMjQOCyAa0f0ggedeHYI98JDbH1+Lc2jPhSUBLzwqFJga
        IFJzD99emfWQpuRh3ras57EHxTmKCA5GKnUsJGwGYHCAeSRNzddxD3zCCprL5HCqxqamF3RReja
        On9BuejN0DMWziNjWQaQBQfeZvUrF+7ypNGLLdTW9dQ==
X-Received: by 2002:a63:ce4a:: with SMTP id r10mr18037352pgi.82.1572238695344;
        Sun, 27 Oct 2019 21:58:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxf7cGAOrHZX6mqNmmABB2ChDH0RPOgv4rgfBLIVuao1ZEmU6jcFyL3+82tR8QvhCZM57Me2g==
X-Received: by 2002:a63:ce4a:: with SMTP id r10mr18037315pgi.82.1572238694870;
        Sun, 27 Oct 2019 21:58:14 -0700 (PDT)
Received: from 2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net (2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:74a9:e8b4:eac5:9609])
        by smtp.gmail.com with ESMTPSA id w6sm9419087pfw.84.2019.10.27.21.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 21:58:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH 2/2] r8152: Add macpassthru support for ThinkPad
 Thunderbolt 3 Dock Gen 2
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <0835B3720019904CB8F7AA43166CEEB2F18EEE4D@RTITMBSVM03.realtek.com.tw>
Date:   Mon, 28 Oct 2019 12:58:11 +0800
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "oliver@neukum.org" <oliver@neukum.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3980F066-6783-45A6-9B34-1D838C2C1A2C@canonical.com>
References: <20191025105919.689-1-kai.heng.feng@canonical.com>
 <20191025105919.689-2-kai.heng.feng@canonical.com>
 <0835B3720019904CB8F7AA43166CEEB2F18EEE4D@RTITMBSVM03.realtek.com.tw>
To:     Hayes Wang <hayeswang@realtek.com>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 28, 2019, at 11:58, Hayes Wang <hayeswang@realtek.com> wrote:
> 
> Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Friday, October 25, 2019 6:59 PM
> [...]
>> @@ -6626,6 +6648,9 @@ static int rtl8152_probe(struct usb_interface *intf,
>> 		netdev->hw_features &= ~NETIF_F_RXCSUM;
>> 	}
>> 
>> +	if (id->driver_info & R8152_QUIRK_LENOVO_MACPASSTHRU)
> 
> Do you really need this?
> It seems the information of idVendor and idProduct is enough. 

Both idVendor and idProduct are just part of "struct usb_device_id".
IMO it's clearer to add quirks there.

> 
>> +		set_bit(LENOVO_MACPASSTHRU, &tp->flags);
>> +
>> 	if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x3011 && udev->serial
>> &&
>> 	    (!strcmp(udev->serial, "000001000000") ||
>> 	     !strcmp(udev->serial, "000002000000"))) {
>> @@ -6754,6 +6779,8 @@ static const struct usb_device_id rtl8152_table[] = {
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f, 0)},
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062, 0)},
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3069, 0)},
>> +	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3082,
>> +			R8152_QUIRK_LENOVO_MACPASSTHRU)},
> 
> This limits the usage of driver_info. For example, I couldn't
> use it to store a pointer address anymore.

But will the driver ever use .driver_info for pointers?
There are many driver use it for quirks and quirks only.

Kai-Heng

> 
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205, 0)},
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x720c, 0)},
>> 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7214, 0)},
>> --
>> 2.17.1
> 

