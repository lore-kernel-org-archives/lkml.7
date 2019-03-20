Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BD3213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xh9iIlFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCTMgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:36:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43086 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfCTMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:36:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KCIvFa149767;
        Wed, 20 Mar 2019 12:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gssUC1640INAedrXMxuLmeKD/p5PYYzJHmxIFmqS0CM=;
 b=Xh9iIlFj/oZfoHxQi4OPziMJy/Ao4IBhmzdU86gn4pFbwW0Cj3uMiH+GqcoOJT5j1bQ1
 q0TPDvugzcBKfMEMDkfz34Qvz9GtBXL82XOh9HeyOqr5pCCE4z59pMWc9U0gHZ/nR5c1
 YJSM39wjVrGMMPpRwdmKVqYSzTmi22xxpLYVaBo8v2aDnwL/PuzRlqBkM+X+lqFZwaFk
 PBTiVILoW0AW9V6SDpD/ECGucaHg3NaGjjxxI8LIUYd2MlObm0/rr9avce2zyr1T7JKd
 s0vsM4bfLwA6RuwxZtl4WjMNDmF+daQPOIRQiv+JIHHnzFFcL5IVtIjzkSJVNt2AsIf9 cQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2r8pnetnqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 12:36:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2KCaQIg023869
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 12:36:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KCaPat003980;
        Wed, 20 Mar 2019 12:36:25 GMT
Received: from kadam (/10.175.25.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 05:36:25 -0700
Date:   Wed, 20 Mar 2019 15:36:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jin Chen <nobijinc@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [RESEND][PATCH 2/2] staging: sm750fb: trivial Camel Case removal
 for setDisplayControl().
Message-ID: <20190320123622.GH2202@kadam>
References: <20190303165532.23727-1-tomli@tomli.me>
 <20190303165532.23727-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303165532.23727-3-tomli@tomli.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=782 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 12:55:32AM +0800, Yifeng Li wrote:
> Rename the function setDisplayControl() to set_display_control().
> This fixes the following checkpatch.pl warning:
> 
>     CHECK: Avoid CamelCase: <setDisplayControl>
> 
> Suggested-by: Jin Chen <nobijinc@gmail.com>
> Signed-off-by: Jin Chen <nobijinc@gmail.com>
> [tomli@tomli.me: resent as trivial patch, reworded the commit message]
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---

Apparently Greg already applied this earlier...  I don't know why the
original patch didn't reach me.  I'm on the devel@driverdev.osuosl.org
list.

Did Jin Chen write this?  If so why does it have a Suggested-by tag for
him?  If not then you should have preserved the authorship credit by
using the From: header in the first line on the commit message...

Anyway, it doesn't matter but hopefully this helps for next time.

regards,
dan carpenter

