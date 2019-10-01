Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805CECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF2F20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="feIl3YlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfJAN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:29:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbfJAN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:29:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DNkpV049191;
        Tue, 1 Oct 2019 13:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vt4Pgq8lRVaTH0vwc7hqag3sS0gO7Q3PcCL8FG4+y6g=;
 b=feIl3YlEj52/vm3ohm1UmFeEDMcgqL9JoWiLSg6zyG6KOxi9Yi1syiWz0iirD6NmsEav
 MTktmnySKlt7lsvSpaK3Vnxu/OIXJw76RVKkZvWrm6wTsUBfeDZrAJyPCkbYnZL95kjM
 H81tj7bWeoVVftfh39zz1s6Sd+1VrhU8ghLouRNrzwg9DNmy/5iqe85ypT7l7hsEGQhv
 aUfrHj7GFH3S2+cnMHAUhLayYXJkqXlblUfC2XJ9uF/zaGSHQ+Uhc/JTiqZjT5OOUmoj
 lnNAQIZz+tZC5bk3Nz+wsNRYU8U95d3X8CLwCwoWgKwuGsYh+mIXgKtMa46kC2IgTWrd KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v9xxunvmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:28:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DSaT7172866;
        Tue, 1 Oct 2019 13:28:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vbmpyjtcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:28:54 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91DSqJ3032633;
        Tue, 1 Oct 2019 13:28:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 06:28:51 -0700
Date:   Tue, 1 Oct 2019 16:28:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Staging: exfat: exfat_super.c: fixed multiple coding
 style issues with camelcase and parentheses
Message-ID: <20191001132832.GF22609@kadam>
References: <20190929145229.38561-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929145229.38561-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 09:52:29AM -0500, Jesse Barton wrote:
> Changed Function Names:
> ffsGetVolInfo -> ffs_get_vol_info
> ffsLookupFile -> ffs_lookup_file
> ffsCreateFile -> ffs_create_file
> ffsReadFile -> ffs_read_file
> ffsWriteFile -> ffs_write_file
> ffsTruncateFile -> ffs_truncate_file
> ffsRemoveFile -> ffs_remove_file
> ffsMoveFile -> ffs_move_file
> ffsSetAttr -> ffs_set_attr
> ffsReadStat -> ffs_read_stat
> ffsWriteStat -> ffs_write_stat
> ffsMapCluster -> ffs_map_cluster
> 
> Removed BUG_ON() and added WARN_ON().
> Removed unnecessary parentheses:
> *(dir_entry->Name) - > *dir_entry->Name

Do these other two things in separate patches.

regards,
dan carpenter

