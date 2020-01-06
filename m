Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE88C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1452D24650
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fwa6GxJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAFHWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:22:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35298 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:22:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0067MZWK120601;
        Mon, 6 Jan 2020 01:22:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578295355;
        bh=JbgEMJAZcphTCT3ArjgkaPbRozfPwgrPxgmVTA/cfuc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fwa6GxJ2BnjQ71dnuF1PBO9+Cp2/gBVVUkeTYdf825Fw4baX90M+vHcS964pAE8l9
         S3MKMWfos0Rc/iZ99GSEWp5OSyFMqoje/ZA6570pVERRzSb1/boNArFkE4BbrgNt7L
         EjUdkU+EFoukN66oeZQFThyj5XVY3nXcWLaD7Sos=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0067MZDV030457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 01:22:35 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 01:22:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 01:22:35 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0067MWuq005200;
        Mon, 6 Jan 2020 01:22:32 -0600
Subject: Re: [PATCH v10 0/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <andriy.shevchenko@intel.com>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>, <peter.harliman.liem@intel.com>
References: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c5df1165-5b8d-f329-582f-15553eb5eb1a@ti.com>
Date:   Mon, 6 Jan 2020 12:54:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/19 7:26 AM, Ramuthevar,Vadivel MuruganX wrote:
> Add eMMC-PHY support for Intel LGM SoC

merged now, Thanks!

-Kishon

> 
> changes in v10:
>   - Rob's review comments update in YAML
>   - drop clock-names since it is single entry
>  
> changes in v9:
>   - Rob's review comments update in YAML
> 
> changes in v8:
>  Remove the extra Signed-of-by
> 
> changes in v7:
>  Rebased to maintainer kernel tree phy-tag-5.5
> 
> changes in v6:
>    - cobined comaptible strings
>    - added as contiguous and can be a single entry for reg properties
> changes in v5:
>    - earlier Review-by tag given by Rob
>    - rework done with syscon parent node.
> 
>  changes in v4:
>    - As per Rob's review: validate 5.2 and 5.3
>    - drop unrelated items.
> 
>  changes in v3:
>    - resolve 'make dt_binding_check' warnings
> 
>  changes in v2:
>    As per Rob Herring review comments, the following updates
>   - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>   - filename is the compatible string plus .yaml
>   - LGM: Lightning Mountain
>   - update maintainer
>   - add intel,syscon under property list
>   - keep one example instead of two
> 
> 
> 
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
>   phy: intel-lgm-emmc: Add support for eMMC PHY
> 
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           |  56 ++++
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/intel/Kconfig                          |   9 +
>  drivers/phy/intel/Makefile                         |   2 +
>  drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
>  6 files changed, 352 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>  create mode 100644 drivers/phy/intel/Kconfig
>  create mode 100644 drivers/phy/intel/Makefile
>  create mode 100644 drivers/phy/intel/phy-intel-emmc.c
> 
