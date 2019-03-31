Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42069C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4D02183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014507;
	bh=tRIiCxvrm5f+xSMbCw4SMyDpguvS8xYMbZjXerUB39Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vEkqvUMoeUTG169lsfFnQRpQJFuuDIrpXHsAjSzDfiGqvH6+18yhnz+lqoXm0z91s
	 eOzbzBF12GflQIDjuh807rFeWeU6Sz/nKFV+326dQBKHe7srKzO5q8yLMSTSetuEmS
	 nGfKkqiyp5jp+pytk2gMsR5QP9PobMRX5NcvihEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfCaGlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45779 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfCaGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so3144249pgk.12;
        Sat, 30 Mar 2019 23:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArP6ifQ7Admn0xS7E4Biy9buh5eQrFr0DgCuzPteb8w=;
        b=s6Fjb6hEJzMge0ZxxekoPDjKRp8WdWx9SIyiFhltmyKdZ5WL2YLNF/WcxmUx9ilx0s
         XRANtxz0cNu0a7lee2IeNqOhr9WLtFER8acreroHatGp39Sq1KLEIaRW1sgXPS1HbKWe
         uTHLgD5GvM5TLxRV1Cqbuosr8nQARMwj1zuYo1V4yBtcvUivyoQeLjC4T/z1HZaCjlpZ
         pKGSSwY4XQedn03KXHJRE8ABrPP5v1CLxex7nbmGhEdC54sbkbEggLXXiULfeQPtnqUh
         Ujkpzxd7BqSdBpRC4h3Mk7Uif1bI9UfFYsQP4k6B8rZte0qVr98Cxyr8eheeXq7PxuI9
         Oszw==
X-Gm-Message-State: APjAAAVanJw2ex6zOsTFsfS9KxuszDd2xXbT0C3iRPtUEIzqPdD9VRHn
        bDVmPGil/X2CO5do8L58ii+CYAT+EQ==
X-Google-Smtp-Source: APXvYqyDLKjPaBr2uNKaDuo/FR1j3LqHRQTA2EXjkKOGJabnzGkF0iWhpIbS9QszDo3Lxftv64w+eg==
X-Received: by 2002:a63:5149:: with SMTP id r9mr15941964pgl.177.1554014502139;
        Sat, 30 Mar 2019 23:41:42 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id z6sm12249228pgo.31.2019.03.30.23.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:41 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:41:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: add header file of ASR8751C pinctrl
 driver
Message-ID: <20190331011915.GA7376@bogus>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-7-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-7-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-7-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:27PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add pinctrl definition and configuration of ASR8751C pins. The
> configuration contains pull up/down, driver strength, edge detection,
> multiple function etc.
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  include/dt-bindings/pinctrl/asr8751c-pinfunc.h | 341 +++++++++++++++++++++++++
>  1 file changed, 341 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/asr8751c-pinfunc.h
> 
> diff --git a/include/dt-bindings/pinctrl/asr8751c-pinfunc.h b/include/dt-bindings/pinctrl/asr8751c-pinfunc.h
> new file mode 100644
> index 0000000..b326a6d
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/asr8751c-pinfunc.h
> @@ -0,0 +1,341 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for ASR Aquila pinctrl bindings.
> + *
> + * Copyright (c) 2019, ASR Microelectronics(Shanghai) Co., Ltd.
> + * All rights reserved.
> + *
> + * Author: Tim Wang <timwang@asrmicro.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

Don't need the GPL boilerplate with the SPDX tag.

> + */
> +
> +#ifndef __DTS_ASR8751C_PINFUNC_H
> +#define __DTS_ASR8751C_PINFUNC_H
> +
> +/*
> + * drive-strength = <value mask>
> + * SLOW0:  < 75MHz
> + * SLOW1:  < 150MHz
> + * MEDIUM: < 200MHz
> + * FAST:   > 200MHz
> + */
> +#define DS_SLOW0		pinctrl-single,drive-strength = <0x0000 0x1800>
> +#define DS_SLOW1		pinctrl-single,drive-strength = <0x0800 0x1800>
> +#define DS_MEDIUM		pinctrl-single,drive-strength = <0x1000 0x1800>
> +#define DS_FAST			pinctrl-single,drive-strength = <0x1800 0x1800>

Don't do complex definitions. Keep it to simple value defines.

> +
> +/*
> + * Edge detect setting
> + * input-schmitt = <value mask>;
> + * input-schmitt-enable = <value enable disable mask>
> + */
> +
> +/* no edge detect */
> +#define EDGE_NONE		pinctrl-single,input-schmitt		= <0x00 0x30>;	\
> +				pinctrl-single,input-schmitt-enable	= <0x40 0x00 0x40 0x40>
> +/* enable edge fall detect only*/
> +#define EDGE_FALL		pinctrl-single,input-schmitt		= <0x20 0x30>;	\
> +				pinctrl-single,input-schmitt-enable	= <0x00 0x00 0x40 0x40>
> +/* enable edge rise detect only */
> +#define EDGE_RISE		pinctrl-single,input-schmitt		= <0x10 0x30>;	\
> +				pinctrl-single,input-schmitt-enable	= <0x00 0x00 0x40 0x40>
> +/* enable edge fall/rise detect */
> +#define EDGE_BOTH		pinctrl-single,input-schmitt		= <0x30 0x30>;	\
> +				pinctrl-single,input-schmitt-enable	= <0x00 0x00 0x40 0x40>
> +
> +/*
> + * bias-pullup = <value enable disable mask>;
> + * bias-pulldown = <value enable disable mask>
> + */
> +
> +/* PULL_SEL controlled by Alternative Function */
> +#define PULL_NONE		pinctrl-single,bias-pullup	= <0x0000 0xc000 0x0000 0xc000>;	\
> +				pinctrl-single,bias-pulldown	= <0x0000 0xa000 0x0000 0xa000>
> +/* PULL_SEL controlled by MFPR, enable PULL_UP, disable PULL_DOWN */
> +#define PULL_UP			pinctrl-single,bias-pullup	= <0xc000 0xc000 0x0000 0xc000>;	\
> +				pinctrl-single,bias-pulldown	= <0x8000 0xa000 0x8000 0xa000>
> +/* PULL_SEL controlled by MFPR, disable PULL_UP, enable PULL_DOWN */
> +#define PULL_DOWN		pinctrl-single,bias-pullup	= <0x8000 0xc000 0x8000 0xc000>; \
> +				pinctrl-single,bias-pulldown	= <0xa000 0xa000 0x0000 0xa000>
> +/* PULL_SEL controlled by MFPR, enable PULL_UP and PULL_DOWN */
> +#define PULL_BOTH		pinctrl-single,bias-pullup	= <0xc000 0xc000 0x8000 0xc000>; \
> +				pinctrl-single,bias-pulldown	= <0xa000 0xa000 0x8000 0xa000>
> +/* PULL_SEL controlled by MFPR, disable PULL_UP and PULL_DOWN */
> +#define PULL_FLOAT		pinctrl-single,bias-pullup	= <0x8000 0x8000 0x0000 0xc000>;	\
> +				pinctrl-single,bias-pulldown	= <0x8000 0x8000 0x0000 0xa000>
> +/* Low Power Mode settings */
> +/* no LPM setting, LPM state same as active */
> +#define LPM_NONE		pinctrl-single,low-power-mode = <0x000 0x388>
> +/* LPM, output 0 */
> +#define LPM_DRIVE_LOW		pinctrl-single,low-power-mode = <0x208 0x388>
> +/* LPM, output 1*/
> +#define LPM_DRIVE_HIGH		pinctrl-single,low-power-mode = <0x308 0x388>
> +/* LPM, input state */
> +#define LPM_FLOAT		pinctrl-single,low-power-mode = <0x288 0x388>
> +
> +/* Active settings */
> +#define MFP_DEFAULT		DS_MEDIUM;PULL_NONE;EDGE_NONE;LPM_NONE
> +#define MFP_PULL_UP		DS_MEDIUM;PULL_UP;EDGE_NONE;LPM_NONE
> +#define MFP_PULL_DOWN		DS_MEDIUM;PULL_DOWN;EDGE_NONE;LPM_NONE
> +#define MFP_PULL_FLOAT		DS_MEDIUM;PULL_FLOAT;EDGE_NONE;LPM_NONE
> +
> +/* LPM output */
> +#define MFP_LPM_DRIVE_HIGH	DS_MEDIUM;PULL_NONE;EDGE_NONE;LPM_DRIVE_HIGH
> +#define MFP_LPM_DRIVE_LOW	DS_MEDIUM;PULL_NONE;EDGE_NONE;LPM_DRIVE_LOW
> +
> +/* LPM input */
> +#define MFP_LPM_FLOAT		DS_MEDIUM;PULL_NONE;EDGE_NONE;LPM_FLOAT
> +#define MFP_LPM_PULL_UP		DS_MEDIUM;PULL_UP;EDGE_NONE;LPM_FLOAT
> +#define MFP_LPM_PULL_DW		DS_MEDIUM;PULL_DOWN;EDGE_NONE;LPM_FLOAT
> +
> +/*
> + * MFP alternative functions 0-7
> + */
> +#define AF0			0x0
> +#define AF1			0x1
> +#define AF2			0x2
> +#define AF3			0x3
> +#define AF4			0x4
> +#define AF5			0x5
> +#define AF6			0x6
> +#define AF7			0x7
> +
> +/*
> + * Pin names and MFPR addresses
> + */
> +#define MFPR_OFFSET(x)	((x) << 2)
> +#define GPIO_00		MFPR_OFFSET(1)
> +#define GPIO_01		MFPR_OFFSET(2)
> +#define GPIO_02		MFPR_OFFSET(3)
> +#define GPIO_03		MFPR_OFFSET(4)
> +#define GPIO_04		MFPR_OFFSET(5)
> +#define GPIO_05		MFPR_OFFSET(6)
> +#define GPIO_06		MFPR_OFFSET(7)
> +#define GPIO_07		MFPR_OFFSET(8)
> +#define GPIO_08		MFPR_OFFSET(9)
> +#define GPIO_09		MFPR_OFFSET(10)
> +#define GPIO_10		MFPR_OFFSET(11)
> +#define GPIO_11		MFPR_OFFSET(12)
> +#define GPIO_12		MFPR_OFFSET(13)
> +#define GPIO_13		MFPR_OFFSET(14)
> +#define GPIO_14		MFPR_OFFSET(15)
> +#define GPIO_15		MFPR_OFFSET(16)
> +#define GPIO_16		MFPR_OFFSET(17)
> +#define GPIO_17		MFPR_OFFSET(18)
> +#define GPIO_18		MFPR_OFFSET(19)
> +#define GPIO_19		MFPR_OFFSET(20)
> +#define GPIO_20		MFPR_OFFSET(21)
> +#define GPIO_21		MFPR_OFFSET(22)
> +#define GPIO_22		MFPR_OFFSET(23)
> +#define GPIO_23		MFPR_OFFSET(24)
> +#define GPIO_24		MFPR_OFFSET(25)
> +#define GPIO_25		MFPR_OFFSET(26)
> +#define RXTXEN		MFPR_OFFSET(27)
> +#define PRI_TXFRAME	MFPR_OFFSET(28)
> +#define SPI0_EN		MFPR_OFFSET(29)
> +#define RF_RESET_N	MFPR_OFFSET(30)
> +#define SEC_SYSCLKEN	MFPR_OFFSET(31)
> +#define PRI_RXFRAME	MFPR_OFFSET(32)
> +#define PRI_RBDP0_0	MFPR_OFFSET(33)
> +#define PRI_RBDP0_1	MFPR_OFFSET(34)
> +#define PRI_RBDP0_2	MFPR_OFFSET(35)
> +#define PRI_RBDP0_3	MFPR_OFFSET(36)
> +#define PRI_RBDP0_4	MFPR_OFFSET(37)
> +#define PRI_RBDP0_5	MFPR_OFFSET(38)
> +#define PRI_RBDP0_6	MFPR_OFFSET(39)
> +#define PRI_RBDP0_7	MFPR_OFFSET(40)
> +#define PRI_RBDP0_8	MFPR_OFFSET(41)
> +#define PRI_RBDP0_9	MFPR_OFFSET(42)
> +#define PRI_RBDP0_10	MFPR_OFFSET(43)
> +#define PRI_MCLK	MFPR_OFFSET(98)
> +#define PRI_RBDP0_11	MFPR_OFFSET(44)
> +#define RXTXDATA	MFPR_OFFSET(45)
> +#define SYSCLK_OUT	MFPR_OFFSET(46)
> +#define PRI_FCLK	MFPR_OFFSET(47)
> +#define PRI_RBDP1_0	MFPR_OFFSET(48)
> +#define PRI_RBDP1_1	MFPR_OFFSET(49)
> +#define SPI0_CLK	MFPR_OFFSET(50)
> +#define PRI_RBDP1_2	MFPR_OFFSET(51)
> +#define PRI_RBDP1_3	MFPR_OFFSET(52)
> +#define PRI_RBDP1_4	MFPR_OFFSET(53)
> +#define PRI_RBDP1_5	MFPR_OFFSET(54)
> +#define PRI_RBDP1_6	MFPR_OFFSET(55)
> +#define PRI_RBDP1_7	MFPR_OFFSET(56)
> +#define PRI_RBDP1_8	MFPR_OFFSET(57)
> +#define PRI_RBDP1_9	MFPR_OFFSET(58)
> +#define SPI0_DIO	MFPR_OFFSET(59)
> +#define PRI_RBDP1_10	MFPR_OFFSET(60)
> +#define PRI_RBDP1_11	MFPR_OFFSET(61)
> +#define SPI1_EN		MFPR_OFFSET(62)
> +#define SEC_RXFRAME	MFPR_OFFSET(63)
> +#define SEC_RBDP0_0	MFPR_OFFSET(64)
> +#define SEC_RBDP0_1	MFPR_OFFSET(65)
> +#define SEC_RBDP0_2	MFPR_OFFSET(66)
> +#define SEC_RBDP0_3	MFPR_OFFSET(67)
> +#define SEC_RBDP0_4	MFPR_OFFSET(68)
> +#define SEC_RBDP0_5	MFPR_OFFSET(69)
> +#define SEC_RBDP0_6	MFPR_OFFSET(70)
> +#define SEC_RBDP0_7	MFPR_OFFSET(71)
> +#define SEC_RBDP0_8	MFPR_OFFSET(72)
> +#define SEC_RBDP0_9	MFPR_OFFSET(73)
> +#define SEC_RBDP0_10	MFPR_OFFSET(74)
> +#define SEC_MCLK	MFPR_OFFSET(99)
> +#define SEC_RBDP0_11	MFPR_OFFSET(75)
> +#define SPI1_CLK	MFPR_OFFSET(76)
> +#define SPI1_DIO	MFPR_OFFSET(77)
> +#define CP_GPO_0	MFPR_OFFSET(78)
> +#define CP_GPO_1	MFPR_OFFSET(79)
> +#define CP_GPO_2	MFPR_OFFSET(80)
> +#define CP_GPO_3	MFPR_OFFSET(81)
> +#define CP_GPO_4	MFPR_OFFSET(82)
> +#define CP_GPO_5	MFPR_OFFSET(83)
> +#define CP_GPO_6	MFPR_OFFSET(84)
> +#define CP_GPO_7	MFPR_OFFSET(85)
> +#define CP_GPO_8	MFPR_OFFSET(86)
> +#define CP_GPO_9	MFPR_OFFSET(87)
> +#define CP_GPO_10	MFPR_OFFSET(88)
> +#define CP_GPO_11	MFPR_OFFSET(89)
> +#define CP_GPO_12	MFPR_OFFSET(90)
> +#define CP_GPO_13	MFPR_OFFSET(91)
> +#define CP_GPO_14	MFPR_OFFSET(92)
> +#define CP_GPO_15	MFPR_OFFSET(93)
> +#define CP_UART_RXD	MFPR_OFFSET(94)
> +#define CP_UART_TXD	MFPR_OFFSET(95)
> +#define CP_UART_RTS	MFPR_OFFSET(96)
> +#define CP_UART_CTS	MFPR_OFFSET(97)
> +#define USIM2_UCLK	MFPR_OFFSET(100)
> +#define USIM2_UIO	MFPR_OFFSET(101)
> +#define USIM2_URSTn	MFPR_OFFSET(102)
> +#define USIM_UCLK	MFPR_OFFSET(103)
> +#define USIM_UIO	MFPR_OFFSET(104)
> +#define USIM_URSTn	MFPR_OFFSET(105)
> +#define MMC1_DAT3	MFPR_OFFSET(110)
> +#define MMC1_DAT2	MFPR_OFFSET(111)
> +#define MMC1_DAT1	MFPR_OFFSET(112)
> +#define MMC1_DAT0	MFPR_OFFSET(113)
> +#define MMC1_CMD	MFPR_OFFSET(114)
> +#define MMC1_CLK	MFPR_OFFSET(115)
> +#define PWR_SCL		MFPR_OFFSET(118)
> +#define PWR_SDA		MFPR_OFFSET(119)
> +#define VCXO_EN		MFPR_OFFSET(120)
> +#define VBAT_DROP	MFPR_OFFSET(121)
> +#define PMIC_INT_N	MFPR_OFFSET(122)
> +#define PRI_TDI		MFPR_OFFSET(123)
> +#define PRI_TMS		MFPR_OFFSET(124)
> +#define PRI_TCK		MFPR_OFFSET(125)
> +#define PRI_TDO		MFPR_OFFSET(126)
> +#define SLAVE_RESET_OUT	MFPR_OFFSET(127)
> +#define VCXO_REQ1	MFPR_OFFSET(128)
> +#define VCXO_REQ	MFPR_OFFSET(129)
> +#define VCXO_OUT	MFPR_OFFSET(130)
> +#define GPIO_26		MFPR_OFFSET(131)
> +#define GPIO_27		MFPR_OFFSET(132)
> +#define GPIO_28		MFPR_OFFSET(133)
> +#define GPIO_29		MFPR_OFFSET(134)
> +#define GPIO_30		MFPR_OFFSET(135)
> +#define GPIO_31		MFPR_OFFSET(136)
> +#define GPIO_32		MFPR_OFFSET(137)
> +#define GPIO_33		MFPR_OFFSET(138)
> +#define GPIO_34		MFPR_OFFSET(139)
> +#define GPIO_35		MFPR_OFFSET(140)
> +#define GPIO_36		MFPR_OFFSET(141)
> +#define GPIO_37		MFPR_OFFSET(142)
> +#define GPIO_38		MFPR_OFFSET(143)
> +#define GPIO_39		MFPR_OFFSET(144)
> +#define GPIO_40		MFPR_OFFSET(145)
> +#define GPIO_41		MFPR_OFFSET(146)
> +#define GPIO_42		MFPR_OFFSET(147)
> +#define GPIO_43		MFPR_OFFSET(148)
> +#define GPIO_44		MFPR_OFFSET(149)
> +#define GPIO_45		MFPR_OFFSET(150)
> +#define GPIO_46		MFPR_OFFSET(151)
> +#define GPIO_47		MFPR_OFFSET(152)
> +#define GPIO_48		MFPR_OFFSET(153)
> +#define GPIO_49		MFPR_OFFSET(154)
> +#define GPIO_50		MFPR_OFFSET(155)
> +#define GPIO_51		MFPR_OFFSET(156)
> +#define GPIO_52		MFPR_OFFSET(157)
> +#define GPIO_53		MFPR_OFFSET(158)
> +#define GPIO_54		MFPR_OFFSET(159)
> +#define GPIO_55		MFPR_OFFSET(160)
> +#define GPIO_56		MFPR_OFFSET(161)
> +#define GPIO_57		MFPR_OFFSET(162)
> +#define GPIO_58		MFPR_OFFSET(163)
> +#define GPIO_59		MFPR_OFFSET(164)
> +#define GPIO_60		MFPR_OFFSET(165)
> +#define GPIO_61		MFPR_OFFSET(166)
> +#define GPIO_62		MFPR_OFFSET(167)
> +#define GPIO_63		MFPR_OFFSET(168)
> +#define GPIO_64		MFPR_OFFSET(169)
> +#define GPIO_65		MFPR_OFFSET(170)
> +#define GPIO_66		MFPR_OFFSET(171)
> +#define GPIO_67		MFPR_OFFSET(172)
> +#define GPIO_68		MFPR_OFFSET(173)
> +#define GPIO_69		MFPR_OFFSET(174)
> +#define GPIO_70		MFPR_OFFSET(175)
> +#define GPIO_71		MFPR_OFFSET(176)
> +#define GPIO_72		MFPR_OFFSET(177)
> +#define GPIO_73		MFPR_OFFSET(178)
> +#define GPIO_74		MFPR_OFFSET(179)
> +#define GPIO_75		MFPR_OFFSET(180)
> +#define GPIO_76		MFPR_OFFSET(181)
> +#define GPIO_77		MFPR_OFFSET(182)
> +#define GPIO_78		MFPR_OFFSET(183)
> +#define GPIO_79		MFPR_OFFSET(184)
> +#define GPIO_80		MFPR_OFFSET(185)
> +#define GPIO_81		MFPR_OFFSET(186)
> +#define GPIO_82		MFPR_OFFSET(187)
> +#define GPIO_83		MFPR_OFFSET(188)
> +#define GPIO_84		MFPR_OFFSET(189)
> +#define GPIO_85		MFPR_OFFSET(190)
> +#define GPIO_86		MFPR_OFFSET(191)
> +#define GPIO_87		MFPR_OFFSET(192)
> +#define GPIO_88		MFPR_OFFSET(193)
> +#define GPIO_89		MFPR_OFFSET(194)
> +#define GPIO_90		MFPR_OFFSET(195)
> +#define GPIO_91		MFPR_OFFSET(196)
> +#define GPIO_92		MFPR_OFFSET(197)
> +#define GPIO_93		MFPR_OFFSET(198)
> +#define GPIO_94		MFPR_OFFSET(199)
> +#define GPIO_95		MFPR_OFFSET(200)
> +#define GPIO_96		MFPR_OFFSET(201)
> +#define GPIO_97		MFPR_OFFSET(202)
> +#define GPIO_98		MFPR_OFFSET(203)
> +#define GPIO_99		MFPR_OFFSET(204)
> +#define GPIO_100	MFPR_OFFSET(205)
> +#define GPIO_101	MFPR_OFFSET(206)
> +#define GPIO_102	MFPR_OFFSET(207)
> +#define GPIO_103	MFPR_OFFSET(208)
> +#define GPIO_104	MFPR_OFFSET(209)
> +#define GPIO_105	MFPR_OFFSET(210)
> +#define GPIO_106	MFPR_OFFSET(211)
> +#define GPIO_107	MFPR_OFFSET(212)
> +#define GPIO_108	MFPR_OFFSET(213)
> +#define GPIO_109	MFPR_OFFSET(214)
> +#define GPIO_110	MFPR_OFFSET(215)
> +#define GPIO_111	MFPR_OFFSET(216)
> +#define GPIO_112	MFPR_OFFSET(217)
> +#define GPIO_113	MFPR_OFFSET(218)
> +#define GPIO_114	MFPR_OFFSET(219)
> +#define GPIO_115	MFPR_OFFSET(220)
> +#define GPIO_116	MFPR_OFFSET(221)
> +#define GPIO_117	MFPR_OFFSET(222)
> +#define GPIO_118	MFPR_OFFSET(223)
> +#define GPIO_119	MFPR_OFFSET(224)
> +#define GPIO_120	MFPR_OFFSET(225)
> +#define GPIO_121	MFPR_OFFSET(226)
> +#define GPIO_122	MFPR_OFFSET(227)
> +#define GPIO_123	MFPR_OFFSET(228)
> +#define GPIO_124	MFPR_OFFSET(229)
> +#define GPIO_125	MFPR_OFFSET(230)
> +#define GPIO_126	MFPR_OFFSET(231)
> +#define GPIO_127	MFPR_OFFSET(232)
> +#endif /* __DTS_ASR8751C_PINFUNC_H */
> -- 
> 2.7.4
> 

