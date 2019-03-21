Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F35218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdjYGLlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCUKY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:24:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:24:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2LANrov181609;
        Thu, 21 Mar 2019 10:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=v0TkPBWgrLmRX0kAD4/pUy041dM3Z5H22OqMdbWAwiQ=;
 b=GdjYGLltvDLGMZHSRme1wNhT4CI31vSNtgLgbKBD+Mlik4G/oKKhIoa2TgAWu3d9hMeT
 ymdyuokeX1t24yqCTrbFsJ9F56yMQWGgAL4xEH3Cuw/Q35s/A7bzEHarazvIOMh8PRg1
 c7kbR8h6JnnvC1wiJa5w7+499U6o3XatZmfRBUY/LZrf9B99wXwdRAnUW1FZB7Q6p0BW
 OtxQpf9Lt2pjwMDAoZ4U9bLhbsFRHyQRYvYt+gGg3vPoesQKn1mSfOs5o6I4akyqFPcg
 XTPogUTpurVUqn9+sx9dsoCYL1G49mPBQc6jg+Dij+omfmqF86EMCrbYr2ubGq3lwcg4 Rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssrqgb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 10:24:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2LAOcMu024317
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 10:24:39 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2LAObFu013098;
        Thu, 21 Mar 2019 10:24:37 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 03:24:36 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190321092138.GY18740@MiWiFi-R3L-srv>
Date:   Thu, 21 Mar 2019 04:24:35 -0600
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <3FFF0A5F-AD27-4F31-8ECF-3B72135CF560@oracle.com>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
 <20190320123658.GF13626@rapoport-lnx>
 <20190320125843.GY19508@bombadil.infradead.org>
 <20190321064029.GW18740@MiWiFi-R3L-srv>
 <20190321092138.GY18740@MiWiFi-R3L-srv>
To:     Baoquan He <bhe@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=760 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2019, at 3:21 AM, Baoquan He <bhe@redhat.com> wrote:

It appears as is so often the case that the usage has far outpaced the
documentation and -EEXIST may be the proper code to return.

The correct answer here may be to modify the documentation to note the
additional semantic, though if the usage is solely within the kernel it
may be sufficient to explain its use in the header comment for the
routine (in this case sparse_add_one_section()).


