Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7CEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5332C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eIhOJkZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfLPBTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 20:19:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:55653 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPBTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 20:19:53 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191216011948epoutp04881f471045fe381049b86f8b2c62040d~gtUeJgOk70931709317epoutp04P
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:19:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191216011948epoutp04881f471045fe381049b86f8b2c62040d~gtUeJgOk70931709317epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576459188;
        bh=8giqkkhX+t6iZYeFY9KVtwUMjXYwL+oSsLFbg5OEA7o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eIhOJkZALNTMtDxyg576IiTryvOQsM4A+bcPWPbeih6DqwzyVlxVTIg5rUSYxPdra
         OhNue7eiHffeUvy4MBWYj46xdGTY3KPteBOPxmRwwP9kBu5VQ22ISuJ1oo2+B0AFYe
         xUit4FFSJSJGKEDjclMJDd6gcoRMxlkRGG8RiXeY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191216011947epcas1p39934fdf7cfd680c3b7ff966262e8f539~gtUdm8D3P2543125431epcas1p3J;
        Mon, 16 Dec 2019 01:19:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47bk2n23rgzMqYkc; Mon, 16 Dec
        2019 01:19:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.8A.48019.EABD6FD5; Mon, 16 Dec 2019 10:19:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216011942epcas1p47aab213d18e13e805056d1e7be2fb729~gtUYNJG0P2204522045epcas1p4c;
        Mon, 16 Dec 2019 01:19:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191216011942epsmtrp257955c838efed5a502a6b714b474cdcd~gtUYMjyxz2826028260epsmtrp2W;
        Mon, 16 Dec 2019 01:19:42 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-80-5df6dbaec84b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.DC.06569.DABD6FD5; Mon, 16 Dec 2019 10:19:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216011941epsmtip2393d421082fd5ab53a31ee10a37df9a2~gtUX_XoVs1339113391epsmtip2a;
        Mon, 16 Dec 2019 01:19:41 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: remove unneeded semicolon
To:     Xu Wang <vulab@iscas.ac.cn>, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6e94aa1e-2669-621b-d70b-f4780ed6705a@samsung.com>
Date:   Mon, 16 Dec 2019 10:26:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1576230514-5049-1-git-send-email-vulab@iscas.ac.cn>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3a367Va3abmaUHNG0JO1F3nbNpmr5SSoBD1obB1mTdn7o3d
        TdK+GGQti0gsypGpVOJWNFBTs0xSywwRZfhCZgRKWKJWllhRtOst8tvvnOf8z3n+z3MITFaK
        y4l8q5N1WBkzha8UN3fFqOIejC3kqOofR2kDbTdx7diZelzrLW0X78TSn7Y2ovTLTT6UPt+w
        KRs7UqAzsUwu61CwVqMtN9+ap6cOHDTsMWiSVXQcnaLdRimsjIXVU3szs+P25ZuDgyhFIWN2
        BVPZDMdRCWk6h83lZBUmG+fUU6w912xPscdzjIVzWfPijTZLKq1SJWqChccLTNUzg2J745pT
        vpnoEnRrVRkKJYBMgkF/RUgZWknIyFYE5W8qRULwBcH74VqJECwgCPjcIf8kc+cfYsJBO4K6
        35+QEMwh6HvxEi9DBBFGpkHdkyJeEE6mQMNAt4RnjFTAj7cNS4yTSuiYGsV5XktGwdDiBOJZ
        GpR+fV4ZwrcRk9HwdKiQT0eQh6G3+ezfknXQWzkp5jmU3AUd09dxoX0kvJ6sFgm8GVpmbi7d
        E8huHNyfRzDBwF7wXmxDAofBx56mv8bkMD/bjgt8Gry93bggdiNo6hiQCAdq6LhbIeIvh5Ex
        4G9LENJR8OhnFRIGr4HZb5ckfAmQUnCfkwklWyDwblwk8Aa4ff4CfgVRnmV2PMsseJZZ8Pwf
        VoPEPrSetXOWPJaj7UnL/7oBLa2gUtuKnvRndiKSQNRq6ZRpIUcmYQq5IksnAgKjwqVs7HyO
        TJrLFBWzDpvB4TKzXCfSBB+7HJNHGG3BhbY6DbQmUa1Wa5PoZA1NU5FSYnEwR0bmMU62gGXt
        rOOfTkSEykuQfTy87Hvffelwwr1D1TVUZsHVkKreGztGambQlVjpqCL16LXXK37FWLtaTmjL
        a3e6vTX39/vqfr81ver3GzOms7b6/JszirnUyGllmuhCWLEWTh6Lntg+ldG3cZve/MB7x+Df
        /bFiN1Vi+JBf9awzgF/U6dye8tJhSU9t4UTWWUrMmRhaiTk45g/0cy2+mAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvO7a299iDdp/Wlhc3jWHzeJ24wo2
        i5Wte1kcmD327djM6NG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZ899eZCnYzFex6q1qA+M8
        7i5GTg4JAROJ9+1bmbsYuTiEBHYzSnxd9JAVIiEpMe3iUaAEB5AtLHH4cDFEzVtGiXlvZrGC
        xIUF7CSW7akEKRcRsJTYdOEIWCuzgILEr3ubWCHqpzBK/Fq6hwUkwSagJbH/xQ02EJtfQFHi
        6o/HjCA2L9CcL0dnsoPMZBFQldh3tQwkLCoQJrFzyWMmiBJBiZMzn4CN4RRwlNj/ejobxC51
        iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKj
        vNRyveLE3OLSvHS95PzcTYzgaNDS2sF44kT8IUYBDkYlHl6H7G+xQqyJZcWVuYcYJTiYlUR4
        U7U/xwrxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpgdNk6
        ocL3mdL3o263Sp6qnlwupKuwq0aB7+izWI9ngqdNEzJfWPdd2/JQ4KPr7I9eq5d/s5O9fOBf
        0saCZZ7GX+KmKz/yjDdmZQwJWvxvgf6C/Q31Z0/P3nju+cRzTlMXbfrgd3zRVTbltLWHfivZ
        qOiFJ51afZ8n4kelZua9WNa/e9NN+/PXLVViKc5INNRiLipOBACGlHsAggIAAA==
X-CMS-MailID: 20191216011942epcas1p47aab213d18e13e805056d1e7be2fb729
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213094853epcas1p4459d16e88cbf5f12f7f682efddd993e7
References: <CGME20191213094853epcas1p4459d16e88cbf5f12f7f682efddd993e7@epcas1p4.samsung.com>
        <1576230514-5049-1-git-send-email-vulab@iscas.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 6:48 PM, Xu Wang wrote:
> remove unneeded semicolon
> This is detected by coccinelle.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/extcon/extcon-sm5502.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index bcf65aa..106d4da 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -249,7 +249,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
>  		dev_err(info->dev, "Unknown DM_CON/DP_CON switch type (%d)\n",
>  				con_sw);
>  		return -EINVAL;
> -	};
> +	}
>  
>  	switch (vbus_sw) {
>  	case VBUSIN_SWITCH_OPEN:
> @@ -268,7 +268,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
>  	default:
>  		dev_err(info->dev, "Unknown VBUS switch type (%d)\n", vbus_sw);
>  		return -EINVAL;
> -	};
> +	}
>  
>  	return 0;
>  }
> @@ -357,13 +357,13 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
>  				"cannot identify the cable type: adc(0x%x)\n",
>  				adc);
>  			return -EINVAL;
> -		};
> +		}
>  		break;
>  	default:
>  		dev_err(info->dev,
>  			"failed to identify the cable type: adc(0x%x)\n", adc);
>  		return -EINVAL;
> -	};
> +	}
>  
>  	return cable_type;
>  }
> @@ -405,7 +405,7 @@ static int sm5502_muic_cable_handler(struct sm5502_muic_info *info,
>  		dev_dbg(info->dev,
>  			"cannot handle this cable_type (0x%x)\n", cable_type);
>  		return 0;
> -	};
> +	}
>  
>  	/* Change internal hardware path(DM_CON/DP_CON, VBUSIN) */
>  	ret = sm5502_muic_set_path(info, con_sw, vbus_sw, attached);
> 

Applied it. Better to use the capital letter for first char
on patch title.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
