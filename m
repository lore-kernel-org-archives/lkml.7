Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A508221734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbfETPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:43:03 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:48770 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388808AbfETPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:43:03 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KFbE8c006270;
        Mon, 20 May 2019 10:42:46 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sjefmtm2j-1;
        Mon, 20 May 2019 10:42:46 -0500
Received: from EDIEX02.ad.cirrus.com (ediex02.ad.cirrus.com [198.61.84.81])
        by mail4.cirrus.com (Postfix) with ESMTP id B8517611C8A7;
        Mon, 20 May 2019 10:43:52 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 May
 2019 16:42:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 May 2019 16:42:45 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B02744;
        Mon, 20 May 2019 16:42:45 +0100 (BST)
Date:   Mon, 20 May 2019 16:42:45 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 07/10] mfd: madera: point to the right pinctrl binding
 file
Message-ID: <20190520154244.GA99937@ediswmail.ad.cirrus.com>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
 <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:47:36AM -0300, Mauro Carvalho Chehab wrote:
> The reference to Documentation/pinctrl.txt doesn't exist, but
> there is an specific binding for the madera driver.
> 
> So, point to it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/linux/mfd/madera/pdata.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> index 8dc852402dbb..c7e0658eb74b 100644
> --- a/include/linux/mfd/madera/pdata.h
> +++ b/include/linux/mfd/madera/pdata.h
> @@ -34,7 +34,8 @@ struct madera_codec_pdata;
>   * @micvdd:	    Substruct of pdata for the MICVDD regulator
>   * @irq_flags:	    Mode for primary IRQ (defaults to active low)
>   * @gpio_base:	    Base GPIO number
> - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> + * @gpio_configs:   Array of GPIO configurations
> + *		    (See Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt)

I believe this is trying to point at the generic pinctrl docs
which now live here:

Documentation/driver-api/pinctl.rst

There is a patch to do this already:
https://lkml.org/lkml/2019/1/9/853
With the latest resend here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2001752.html

Thanks,
Charles

>   * @n_gpio_configs: Number of entries in gpio_configs
>   * @gpsw:	    General purpose switch mode setting. Depends on the external
>   *		    hardware connected to the switch. (See the SW1_MODE field
> -- 
> 2.21.0
> 
