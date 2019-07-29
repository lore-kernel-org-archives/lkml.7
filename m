Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35BEC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC705206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="wA7J2AKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfG2UvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:51:21 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:59550 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfG2UvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:51:21 -0400
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 6B0429F336;
        Mon, 29 Jul 2019 22:51:16 +0200 (CEST)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id x6TKpDUB004687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 22:51:14 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com x6TKpDUB004687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1564433474;
        bh=6ljlJMatrdxIbp7G8j3piVq/RmCpOA7jw8LOUhZS0e4=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=wA7J2AKXqv3RX87gouRFV0ZBkLJDRZuP0YoV/H5YXV2jxYm5CcT7W7NvmzTmI4FF7
         8rSK/cKAvkFgIInGG2gTdJHhd571UTTlY+58wJrlBVxD5QywdtafK9SZ5Q1mWEAkpw
         NZYI1J0Ffb4jF6Jj+/8WFcVKnv+Kx5Z9/Gho4iEyF19j+7hqmWHmna+NVqNOro3KwF
         /dNIq8c2aFFtNJ6yMjAC0m70Qji510KGQ+XGRN+rOn5g7/HezmJELxqFIgJ3+TzlY/
         5dhpW72EI3rG4T1QRs1MbIb8NJfHimoMb96gVTWmw8kwEDdm2IabpS0WiOVP7KXI6d
         7mT/OTesPiRdHFvYaQSj+UleJAxDL4JkjUelFMfLrmfnvGDS6eJXMkkudTGnyv8nIw
         th+3/dwSLuIn21+Ey8/UyMVYclTQ1LsnFr4UhEGP/nlQBs1eKge+RDbDmK1XL/g5Gz
         P8sa9R0INd80nmoobyad7KKT15upAnNMxq4q5DqLOCDhwcZCGHj1u6nSEMXHVbhnVd
         K658a30j60ibFiZVTpfIBgglWQDj5sCL7aSaA+V37UUoVTnqlIpRmCgv4ZYEeOraYJ
         KUwXe2Sduhi3A5/I07Kl2JeiejTapZ7wYKuyoLW96PwAFPAQ40pafKKxWFjR3DU+sl
         66Tzp1tA4GfGhAkPKjNy7phA=
From:   Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: platform/x86/pcengines-apuv2: Missing apu4
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <02b34d18-27bc-cb48-f698-03df61df7d91@wiesinger.com>
 <343400be-bd86-b59c-cfa0-862780493450@metux.net>
Message-ID: <e4d495d5-bd3a-df31-bda3-b69d6d9146a1@wiesinger.com>
Date:   Mon, 29 Jul 2019 22:51:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <343400be-bd86-b59c-cfa0-862780493450@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.2019 10:35, Enrico Weigelt, metux IT consult wrote:
> On 26.07.19 16:56, Gerhard Wiesinger wrote:
>> Hello,
>>
>> I saw that the apu4 board is completly missing (also on 5.3rc1). Can 
>> you please add it. Should be very easy, see below.
>
> Still in the pipeline - don't have an apu4 board for testing yet.
>
>
Delta to e.g. apu3 can be found in the repo, see below 
(https://github.com/pcengines/coreboot)


dmidecode|grep -iE 'engines|apu'
         Manufacturer: PC Engines
         Product Name: apu4
         Manufacturer: PC Engines
         Product Name: apu4
         Manufacturer: PC Engines

So risk of the patch is minimal.


I can test it if patch is integrated.

Ciao,

Gerhard

--- pcengines_apu3.config    Fri Jul 26 11:33:41 2019
+++ pcengines_apu4.config    Fri Jul 26 11:33:41 2019
@@ -30,14 +30,14 @@
  #
  CONFIG_VENDOR_PCENGINES=y
  # CONFIG_BOARD_PCENGINES_APU2 is not set
-CONFIG_BOARD_PCENGINES_APU3=y
-# CONFIG_BOARD_PCENGINES_APU4 is not set
+# CONFIG_BOARD_PCENGINES_APU3 is not set
+CONFIG_BOARD_PCENGINES_APU4=y
  # CONFIG_BOARD_PCENGINES_APU5 is not set
  CONFIG_BOARD_SPECIFIC_OPTIONS=y
-CONFIG_VARIANT_DIR="apu3"
+CONFIG_VARIANT_DIR="apu4"
  CONFIG_DEVICETREE="variants/$(CONFIG_VARIANT_DIR)/devicetree.cb"
  CONFIG_MAINBOARD_DIR="pcengines/apu2"
-CONFIG_MAINBOARD_PART_NUMBER="apu3"
+CONFIG_MAINBOARD_PART_NUMBER="apu4"
  # CONFIG_SVI2_SLOW_SPEED is not set
  CONFIG_SVI_WAIT_COMP_DIS=y
  CONFIG_HW_MEM_HOLE_SIZEK=0x200000
@@ -397,7 +397,7 @@
  CONFIG_MAINBOARD_SERIAL_NUMBER="123456789"
  CONFIG_MAINBOARD_VERSION="1.0"
  CONFIG_MAINBOARD_SMBIOS_MANUFACTURER="PC Engines"
-CONFIG_MAINBOARD_SMBIOS_PRODUCT_NAME="apu3"
+CONFIG_MAINBOARD_SMBIOS_PRODUCT_NAME="apu4"

  #
  # Payload

