Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16120C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDBryFe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfH1QBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:01:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40150 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfH1QBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:01:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SFwowN185805;
        Wed, 28 Aug 2019 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Rkw68eqQsYdcafi4t1MlTcvEd1L2WWVYUXeJnNKMnQA=;
 b=HDBryFe4z+UPhgajDDvs6+7lruodP2W+gy2Jj7n1GTovUDPK42sinURVH1gD7zLuXjL1
 VjjLaWQ8YFR+hqiNtxXdB6nBhJLuPWJITPHT+q9got0UpdLx9O9rZJKFfCPACeaFc9Wi
 ykoBftKynZabNgrG/tEwFXb2bhSlnIQlMN5UYzyeop35MVbIU8fTdSHz780hBj0BLKat
 suF2WFrBs2sGml0aqEaMTj2KRr7Aljedm0Vu+iprQ3x9DbMo+nDuyZ7kiM3nQdLVyf55
 CqekRDAcTfbHDk/FjH8Ctx2INQ0rQMZ0GDvQiOD1lGJp7/5DtJGguoNc0cYrzL6LKIWc Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2unvkmr3bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 16:01:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SFx3lm072120;
        Wed, 28 Aug 2019 16:01:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2undw7mah5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 16:01:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SG1dCH022539;
        Wed, 28 Aug 2019 16:01:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 09:01:39 -0700
Date:   Wed, 28 Aug 2019 09:01:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: add entry for LICENSES and SPDX stuff
Message-ID: <20190828160137.GV1037422@magnolia>
References: <20190827172519.GA28849@kroah.com>
 <20190827195310.GA30618@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827195310.GA30618@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:53:10PM +0200, Greg Kroah-Hartman wrote:
> Thomas and I seem to have become the "unofficial" maintainers for these
> files and questions about SPDX things.  So let's make it official.
> 
> Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> v2:	add Documentation/process/license-rules.rst
> 
>  MAINTAINERS |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9234,6 +9234,18 @@ F:	include/linux/nd.h
>  F:	include/linux/libnvdimm.h
>  F:	include/uapi/linux/ndctl.h
>  
> +LICENSES and SPDX stuff
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +L:	linux-spdx@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
> +F:	COPYING
> +F:	Documentation/process/license-rules.rst
> +F:	LICENSES/
> +F:	scripts/spdxcheck-test.sh
> +F:	scripts/spdxcheck.py
> +
>  LIGHTNVM PLATFORM SUPPORT
>  M:	Matias Bjorling <mb@lightnvm.io>
>  W:	http://github/OpenChannelSSD
