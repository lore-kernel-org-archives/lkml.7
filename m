Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C92063F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ryl8/Pde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfFZO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:57:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:57:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEsBPp120867;
        Wed, 26 Jun 2019 14:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=8doc8T026Qgzuel0n4TKmmc52HYkNsZ8TF7JIVqwUFg=;
 b=ryl8/PdeUbI/B9eSS4S6nDmMCIqINo/1uxF5TiHQiv+WXs1GrX1Wum7t4Xme2DAwBW/W
 SFNxoE+csDzrSvk2PeLXRLFt+3kXaSJPoaq3QpDPlAmte0vkBWmNtN5hS6YcyZF/i1Rz
 wIAkyLtbYtM34lfknPjRv9ukNn0MbIK0MRGWV3wCb4tphVrc9Fk7ONa3PaQVAABeoCOn
 zfd3uGfTSLNKbiOyIPDtzm0Po8uJdhVeQhDkZKCWLo6wzA/eePTqPrS2HTDo9zzDtU0f
 VEaAi6wjW0sN/wMUukqXvsSTAqCPmOh3YlXQ66HwfmCgJLeNuXQg14nc/0n+kecAawW7 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqjt1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:57:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEtVW7064320;
        Wed, 26 Jun 2019 14:57:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9accr86d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:57:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QEutnF007543;
        Wed, 26 Jun 2019 14:56:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 07:56:55 -0700
Date:   Wed, 26 Jun 2019 17:56:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tobias =?iso-8859-1?Q?Nie=DFen?= 
        <tobias.niessen@stud.uni-hannover.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Sabrina Gaube <sabrina-gaube@web.de>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to
 improve code style
Message-ID: <20190626145636.GG28859@kadam>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
 <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=784
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=837 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both these patches seem fine.

On Wed, Jun 26, 2019 at 04:28:56PM +0200, Tobias Nieﬂen wrote:
> This commit uses the fact that
> 
>     if (a) {
>             if (b) {
>                     ...
>             }
>     }
> 
> can instead be written as
> 
>     if (a && b) {
>             ...
>     }
> 
> without any change in behavior, allowing to decrease the indentation
> of the contained code block and thus reducing the average line length.
> 
> Signed-off-by: Tobias Nieﬂen <tobias.niessen@stud.uni-hannover.de>
> Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>

Signed-off-by is like signing a legal document that you didn't put any
of SCO's secret UNIXWARE source code into your patch or do other illegal
activities.  Everyone who handles a patch is supposed to Sign it.

It's weird to see Sabrina randomly signing your patches.  Probably there
is a more appropriate kind of tag to use as well or instead such as
Co-Developed-by, Reviewed-by or Suggested-by.

regards,
dan carpenter

