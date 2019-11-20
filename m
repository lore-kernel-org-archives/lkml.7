Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C6D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fXFolFfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfKTPFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:05:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbfKTPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:05:11 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKEv3XH012326;
        Wed, 20 Nov 2019 16:04:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=B4eTGdmy9M6RCxNN9IMGP9gViNyeowzelSDgABH62j0=;
 b=fXFolFfTBnHvkrJczHAFOGhstYXWmPF1ic+/nyQXCPpTF9LJA4cGSmNYX59jMj1anpz3
 CVZuhz8WsM0kkVwpl2WaTHGYHQpSMP2ESQjyEaj6DgsPNF6Cc7or/cBrXWO7Ffprpz9X
 DgGQqHbP6ZWd1hpwzXcVeJwRVKNRCpmqt+NMO6qYsRVZKrj6+n3nx9CagynpAJasjWjg
 FUPNF7Of05JQ5Hx4zoJNv0OB76YPVKGeNmIeApVkvU/0FNvb89UyR15w4b8g4n0h73vx
 yind01xOACT4Uugyzo34/OF00K0A6hmSZrfnWeCAr5r9rxh7kk/hy2Gq6uUvCiPpKy6j 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9up6nbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 16:04:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A83510002A;
        Wed, 20 Nov 2019 16:04:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E82D62B4F11;
        Wed, 20 Nov 2019 16:04:55 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Nov
 2019 16:04:54 +0100
Subject: Re: [PATCH 0/6] STM32 DT: Updates for SOC diversity
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20191120144109.25321-1-alexandre.torgue@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <29723f43-11cb-1e95-80a0-407c99a14208@st.com>
Date:   Wed, 20 Nov 2019 16:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120144109.25321-1-alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_04:2019-11-15,2019-11-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 3:41 PM, Alexandre Torgue wrote:
> This series updates stm32mp device tree files in order to handle the STM32MP15
> part numbers diversity. STM32MP15 part numbers are built in this way:
> 
> -STM32MP15X: X = [1, 3, 7] for IPs diversity:
>   -STM32MP151 = basic part
>   -STM32MP153 = STM32MP153  + a second CPU A7 + MCAN(x2)

Sorry for typo: -STM32MP153 = STM32MP151  + a second CPU A7 + MCAN(x2)

>   -STM32MP157 = STM32MP153 + DSI + GPU
> 
> -STMM32MP15xY: Y = [a, c] for security diversity:
>   -STM32MP15xA: basic part.
>   -STM32MP15xC: adds crypto IP.
> 
> -STM32MP15xxZZ: ZZ = [aa, ab, ac, ad] for packages (IO) diversity:
>   -STM32MP15xxAA: TFBGA448 18x18
>   -STM32MP15xxAB: LFBGA354 16x16
>   -STM32MP15xxAC: TFBGA361 12x12
>   -STM32MP15xxAD: TFBGA257 10x10
> 
> New device tree files are created and some existing are renamed to match with
> this split.
> 
> In this way it is easy to assemble (by inclusion) those files to match with the
> SOC partnumber used on board, and then it's simpler for users to create their
> own device tree board file using the correct SOC.
> 
> For more details:
> 
> See STM32MP151 [1], STM32MP153 [2], STM32MP157 [3] reference manuals:
>   [1] https://www.st.com/resource/en/reference_manual/dm00366349.pdf
>   [2] https://www.st.com/resource/en/reference_manual/dm00366355.pdf
>   [3] https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> 
> Product family:
>   https://www.st.com/en/microcontrollers-microprocessors/stm32-arm-cortex-mpus.html#products
> 
> regards
> Alex
> 
> Alexandre Torgue (6):
>    ARM: dts: stm32: Adapt stm32mp157 pinctrl to manage STM32MP15xx SOCs
>      family
>    ARM: dts: stm32: Update stm32mp157 pinctrl files
>    ARM: dts: stm32: Introduce new STM32MP15 SOCs: STM32MP151 and
>      STM32MP153
>    ARM: dts: stm32: Manage security diversity for STM32M15x SOCs
>    ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32 DT diversity
>    ARM: dts: stm32: Adapt STM32MP157C ED1 board to STM32 DT diversity
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      | 1087 +++++++++++++++
>   .../dts/{stm32mp157c.dtsi => stm32mp151.dtsi} |  218 ++-
>   arch/arm/boot/dts/stm32mp153.dtsi             |   45 +
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     | 1240 -----------------
>   arch/arm/boot/dts/stm32mp157.dtsi             |   31 +
>   arch/arm/boot/dts/stm32mp157a-avenger96.dts   |    5 +-
>   arch/arm/boot/dts/stm32mp157a-dk1.dts         |  604 +-------
>   arch/arm/boot/dts/stm32mp157c-dk2.dts         |    6 +-
>   arch/arm/boot/dts/stm32mp157c-ed1.dts         |    6 +-
>   arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi  |   90 --
>   arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi  |   62 -
>   arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi  |   78 --
>   arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi  |   62 -
>   arch/arm/boot/dts/stm32mp15xc.dtsi            |   18 +
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  606 ++++++++
>   arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi  |   85 ++
>   arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi  |   57 +
>   arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi  |   73 +
>   arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi  |   57 +
>   19 files changed, 2232 insertions(+), 2198 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>   rename arch/arm/boot/dts/{stm32mp157c.dtsi => stm32mp151.dtsi} (91%)
>   create mode 100644 arch/arm/boot/dts/stm32mp153.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp157.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xc.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi
> 
