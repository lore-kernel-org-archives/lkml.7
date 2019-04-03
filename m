Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA0B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q+enQPaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfDCIiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:38:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36718 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:38:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x338ciIw023312;
        Wed, 3 Apr 2019 03:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554280724;
        bh=2+92lOAnIb4nDuN2GD+TiXrbfsW+rKJoNouWFwCs7WY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q+enQPaQONuwprf1OUTYOgo328QicvXG48YffryMETZec+mSJy56aKYzWIHgQRjHf
         +SdgaDEwj5tXnQfJXx/nIJfXeko98eA1guXp5KU278QaYE7clig2qdZAOBbmkm5k0F
         /OGbyGOBujRAynAhAhGE3m1dUJD2CwN+KP5193aA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x338ciW2030929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 03:38:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 03:38:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 03:38:43 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x338cgRg058214;
        Wed, 3 Apr 2019 03:38:42 -0500
Subject: Re: [RFC PATCH 1/4] ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4
 disabled
To:     Tony Lindgren <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-2-rogerq@ti.com> <20190402162203.GL49658@atomide.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <e53664ff-4376-99eb-8fc5-ab335a59085a@ti.com>
Date:   Wed, 3 Apr 2019 11:38:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402162203.GL49658@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 19:22, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190402 13:38]:
>> These 2 modules are not present on all families (e.g. AM57).
>> Keep them disabled.
> 
> Can you please add comments to the dtsi file for why "disabled"
> is set? Otherwise we may end up removing them at some point as
> the default should be just enabled with no status property.
> 
> If these devices are really there for some SoCs, we should
> have a separate dtsi for them.

They are there on J6 variants but not on AM5 variants.

OK. I will move them to a separate dtsi and include them in the
right variants.

The patch can be independent of this series.

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
