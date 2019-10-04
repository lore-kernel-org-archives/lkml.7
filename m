Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D66C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7B7222C8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fsq89Rd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbfJDOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:47:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54732 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388870AbfJDOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:47:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94Ell5B032160;
        Fri, 4 Oct 2019 09:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570200467;
        bh=7qOqH+UaHjr0iMtnAPK2dzDdM72fjghc21GMKR1fG5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fsq89Rd2M4r4BaiRjFPNi+7AK/kbkaKNf+gF59CCCTuHladC0plahNthGEzOTwOgH
         VISUNH0TEHIoW3eCHLbmK6GRJ+mLwNFbYQMRlniaH3C7/zKqemBTPjUVJ7TW6miJrR
         cM5zNQs0lT7FbH9+Ly2x141VlXdJ5e2Qhfastu4c=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94Ell4A068801;
        Fri, 4 Oct 2019 09:47:47 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 09:47:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 09:47:47 -0500
Received: from [10.250.95.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94Elk4u065937;
        Fri, 4 Oct 2019 09:47:47 -0500
Subject: Re: [PATCH 1/3] mfd: wm8998: Remove some unused registers
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <32854b25-d7b8-af85-b5a6-0d37386cee4a@ti.com>
Date:   Fri, 4 Oct 2019 10:47:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 9:46 AM, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 


Why do this? There is no commit message..

Andrew


> Patch is new to the series.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/wm8998-tables.c           | 12 ------------
>  include/linux/mfd/arizona/registers.h |  7 -------
>  2 files changed, 19 deletions(-)
> 
> diff --git a/drivers/mfd/wm8998-tables.c b/drivers/mfd/wm8998-tables.c
> index ebf0eadd2075c..9b34a6d760949 100644
> --- a/drivers/mfd/wm8998-tables.c
> +++ b/drivers/mfd/wm8998-tables.c
> @@ -806,12 +806,6 @@ static const struct reg_default wm8998_reg_default[] = {
>  	{ 0x00000EF3, 0x0000 },    /* R3827  - ISRC 2 CTRL 1 */
>  	{ 0x00000EF4, 0x0001 },    /* R3828  - ISRC 2 CTRL 2 */
>  	{ 0x00000EF5, 0x0000 },    /* R3829  - ISRC 2 CTRL 3 */
> -	{ 0x00001700, 0x0000 },    /* R5888  - FRF_COEFF_1 */
> -	{ 0x00001701, 0x0000 },    /* R5889  - FRF_COEFF_2 */
> -	{ 0x00001702, 0x0000 },    /* R5890  - FRF_COEFF_3 */
> -	{ 0x00001703, 0x0000 },    /* R5891  - FRF_COEFF_4 */
> -	{ 0x00001704, 0x0000 },    /* R5892  - DAC_COMP_1 */
> -	{ 0x00001705, 0x0000 },    /* R5893  - DAC_COMP_2 */
>  };
>  
>  static bool wm8998_readable_register(struct device *dev, unsigned int reg)
> @@ -1492,12 +1486,6 @@ static bool wm8998_readable_register(struct device *dev, unsigned int reg)
>  	case ARIZONA_ISRC_2_CTRL_1:
>  	case ARIZONA_ISRC_2_CTRL_2:
>  	case ARIZONA_ISRC_2_CTRL_3:
> -	case ARIZONA_FRF_COEFF_1:
> -	case ARIZONA_FRF_COEFF_2:
> -	case ARIZONA_FRF_COEFF_3:
> -	case ARIZONA_FRF_COEFF_4:
> -	case ARIZONA_V2_DAC_COMP_1:
> -	case ARIZONA_V2_DAC_COMP_2:
>  		return true;
>  	default:
>  		return false;
> diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
> index bb1a2530ae279..49e24d1de8d47 100644
> --- a/include/linux/mfd/arizona/registers.h
> +++ b/include/linux/mfd/arizona/registers.h
> @@ -1186,13 +1186,6 @@
>  #define ARIZONA_DSP4_SCRATCH_1                   0x1441
>  #define ARIZONA_DSP4_SCRATCH_2                   0x1442
>  #define ARIZONA_DSP4_SCRATCH_3                   0x1443
> -#define ARIZONA_FRF_COEFF_1                      0x1700
> -#define ARIZONA_FRF_COEFF_2                      0x1701
> -#define ARIZONA_FRF_COEFF_3                      0x1702
> -#define ARIZONA_FRF_COEFF_4                      0x1703
> -#define ARIZONA_V2_DAC_COMP_1                    0x1704
> -#define ARIZONA_V2_DAC_COMP_2                    0x1705
> -
>  
>  /*
>   * Field Definitions.
> 
