Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB94BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6CF20640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCSNuOYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:33:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35204 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:33:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB39T0SS019198;
        Tue, 3 Dec 2019 09:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=G8qpUvWbIVhcVzKpHu2CsxlCDVgrkg66RsvLNXqXNl8=;
 b=nCSNuOYAh6ziBFF0IvuA1+h49z9QE5+f81FhUW+xvz5N615QMU+DQBVpxDaFhe+zD4+e
 0tkwBdBH4HGiSulWTnoHb4OGNUGkGV+B6gJ0pZ52noPl63qjkJTyAGRiyt9kPcloPmtn
 resYoLRwvZpHy9uEpU1GqDxW9GG3C0vCGVf2AzkC2Mrq6xgATwxtBPGd698C9tkocwAG
 IuAQC9Vb+aAvdeODDqTZsTW98AgTmvFKWqUStR6bkRN1YqWVipOh1hp/UuIxbKgVC01d
 J9u0yLhc3w4hUVQb555MSFIkdw8bqSS60UTx+ZFt/t61CzwRLGKZ+REb673pDlQ5bl7t 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcq68cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 09:32:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB39SvJJ021937;
        Tue, 3 Dec 2019 09:32:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wn4qpmbqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 09:32:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB39WpiG003982;
        Tue, 3 Dec 2019 09:32:51 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 01:32:50 -0800
Date:   Tue, 3 Dec 2019 12:32:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kbuild@lists.01.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH next 2/3] debugfs: introduce
 debugfs_create_single[,_data]
Message-ID: <20191203092643.GD1787@kadam>
References: <20191203083847.GC1787@kadam>
 <06d63c3c-bab5-c19e-a51d-ac7c1ed0a80c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d63c3c-bab5-c19e-a51d-ac7c1ed0a80c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 05:02:54PM +0800, Rong Chen wrote:
> 
> 
> On 12/3/19 4:38 PM, Dan Carpenter wrote:
> > [ How do I fetch 0day git branchs?
> >    git fetch https://github.com/0day-ci/linux/commits/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> >    doesn't work. - dan ]
> 
> Hi Dan,
> 
> I can fetch it by the following steps:
> 
> nfs@shao2-debian:~/linux$ git remote add 0day-linux-review
> https://github.com/0day-ci/linux.git
> nfs@shao2-debian:~/linux$ git fetch --no-tags 0day-linux-review
> Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> 
> remote: Enumerating objects: 25261, done.
> remote: Counting objects: 100% (25261/25261), done.
> remote: Total 33246 (delta 25260), reused 25260 (delta 25260), pack-reused
> 7985
> Receiving objects: 100% (33246/33246), 12.03 MiB | 1.05 MiB/s, done.
> Resolving deltas: 100% (28148/28148), completed with 6149 local objects.
> From https://github.com/0day-ci/linux
>  * branch
> Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> -> FETCH_HEAD
>  * [new branch]
> Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> -> 0day-linux-review/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> 

Tracking a remote is unworkably slow on my system.  It's way better to
try fetch a specific branch if possible.

regards,
dan carpenter

