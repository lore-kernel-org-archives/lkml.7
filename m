Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDC4214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V52WKhCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfKGQPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:15:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKGQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:15:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7G90cw123457;
        Thu, 7 Nov 2019 16:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cDbMDrdbwRjBIaXojo8T1eL41dXCzooWpNecrh2E2qo=;
 b=V52WKhCzH5PhNq6I0ApDzVXldCZjW3CNLoJIslhtvfC6Pb2qFxR8qm5fc2LO5XT8MQPj
 0gHTXya02EKojmpaA2MzeaA43/eAq/zA0DegXMFwK6zm3EEvDPIbqC5U4z1Agv99clk8
 InfX5B/xXWt61HA2cc2ryiNHkx89zE6IajD9lGaZEuHX69EcFZNhC+WJfaGyhsqGNMMW
 dGYllj6b/DqIdC8werAfz2nsxVSKj7uTlINfr2RKEMWAUPLw8ebJuMaD7xs5a5rGnz5+
 opun95gY3AuSPKgghHAg83UInsXtRztKvfP5NyBFZ3SNI64UBd0vpWWDgiIDwuJ5lpUa 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w41w0y9wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 16:13:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7GDL4a159999;
        Thu, 7 Nov 2019 16:13:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w41wf9as1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 16:13:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7GCk96019982;
        Thu, 7 Nov 2019 16:12:46 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 08:12:46 -0800
Date:   Thu, 7 Nov 2019 19:12:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     devel@drivrdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] staging: octeon: fix missing a blank line after
 declaration
Message-ID: <20191107143130.GP10409@kadam>
References: <20191107141335.17641-1-ivalery111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107141335.17641-1-ivalery111@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=556
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=655 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:13:22PM +0000, Valery Ivanov wrote:
> 	This patch fixes "WARNING: Missing a blank line after declarations"
> 	Issue found by checkpatch.pl

I think maybe you are cutting and pasting from git log output or
something?  Anyway, please don't indent your commit message like this.

regards,
dan carpenter

