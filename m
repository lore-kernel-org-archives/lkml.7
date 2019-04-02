Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE452082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqiS0wta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDBGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:07:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:07:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32654ql129474;
        Tue, 2 Apr 2019 06:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Fq54SnJkzVuI4KaDao+CAv4++lvhVIq6693ww3VoYM8=;
 b=mqiS0wtaa+7cWlyGslotBC3o1qxgFJSMXZqLXInI5WWPyGh+0rcRnsQ6K/wB1sT2NL16
 QqRqNL7O8/2bbIO0LnvqedfFmq+ME8YZ2OwNZB25pSfMfE35MeAi4qxb7nevU+i4dzA7
 aY151KZ1z6Da23/RBOCYENPwbRwc/frZVNJNEn6MJiVBkszYMRxBBwH2MhSpwOQvqGvY
 mGOlziyl0jRY4bP+oJvhRQO2aAafU1BE4ZC9sSdoRiHSE85PBX2kHXEtBRoGbJRW7UP9
 BgV0YPFyF5MvNAtO1mdxda3QEbVi1Wkl4vhs8m6xrxWGYgETvRSIJ4w3oHO6lnLl4OIL +g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2rj13q2utn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 06:07:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x3267W5R018211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 06:07:32 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3267VKD006880;
        Tue, 2 Apr 2019 06:07:31 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 23:07:30 -0700
Date:   Tue, 2 Apr 2019 09:07:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Will Cunningham <wjcunningham7@gmail.com>
Cc:     johan@kernel.org, devel@driverdev.osuosl.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        elder@linaro.org, joe@perches.com
Subject: Re: [PATCH v2] Staging: greybus: usb: Fixed a coding style error
Message-ID: <20190402060719.GD32590@kadam>
References: <20190401142208.GA12744@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401142208.GA12744@titus.pi.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:22:08AM -0400, Will Cunningham wrote:
> Line was >80 characters.
> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
> Changes in v2:
>  - Created a tmp variable to shorten line length.
> ---
>  drivers/staging/greybus/usb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 1c246c73a085..c09793b48850 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -163,14 +163,14 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
>  	struct gb_usb_device *gb_usb_dev;
>  	struct usb_hcd *hcd;
>  	int retval;
> +	u16 tmp;
>  
>  	hcd = usb_create_hcd(&usb_gb_hc_driver, dev, dev_name(dev));
>  	if (!hcd)
>  		return -ENOMEM;
>  
> -	connection = gb_connection_create(gbphy_dev->bundle,
> -					  le16_to_cpu(gbphy_dev->cport_desc->id),
> -					  NULL);
> +	tmp = le16_to_cpu(gbphy_dev->cport_desc->id);
> +	connection = gb_connection_create(gbphy_dev->bundle, tmp, NULL);


"tmp" is the wrong name...  :/

Like Joe said, it's doesn't help readability to introduce one time use
temporary variables just to make the line lengths shorter.  This line is
81 characters.  It's fine.  Just leave the original as is.

regards,
dan carpenter

