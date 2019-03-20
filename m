Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA75EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A922184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NoAQCMKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCTNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:09:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTNJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:09:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KD8dPT163086;
        Wed, 20 Mar 2019 13:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JSDYeuShhyDCH3/IuB6WC/bUZLns4NrINdoZHf0IE2o=;
 b=NoAQCMKe1JkYPK9+nU7u+HbxJkkB6fTwuoUH63LKXpOsfU3yMew4RZyZIr9jJcOc/8Ln
 ETgLhUuV4M1PJyesClN9VIt5QUD18yxPcWfkyw2BhgPYt9Hsbb6GNY6kbLNK7zGuLCTA
 cQWpn7M/4M76ycNR1MeCtiI9Vj6D+voBfU8sTxBDwwImckKXXOqaAZofW7E0uVJHf0eT
 9Ne6pN9/eCL5o1ixalen61+4IuBEfz8F4pXr6Vgrf4HxGfvrwqhcDT6BM5ofQqjaGwQl
 78iXo73IDP/TYd4PWdRv9k6Mz09Xh9++p2J5JLrV7NbLLgISX0ibzCBXVrryY3fEyGb4 rw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r8ssrjgfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 13:08:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2KD8q2a007698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 13:08:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KD8qtd027902;
        Wed, 20 Mar 2019 13:08:52 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 06:08:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] list.h: fix list_is_first() kernel-doc
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <ddce8b80-9a8a-d52d-3546-87b2211c089a@infradead.org>
Date:   Wed, 20 Mar 2019 07:08:51 -0600
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B02177E-55BC-47F2-8374-FBCAC25134C5@oracle.com>
References: <ddce8b80-9a8a-d52d-3546-87b2211c089a@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=961 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2019, at 6:16 PM, Randy Dunlap <rdunlap@infradead.org> =
wrote:
>=20
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Fix typo of kernel-doc parameter notation (there should be
> no space between '@' and the parameter name).
>=20
> Also fixes bogus kernel-doc notation output formatting.
>=20
> Fixes: 70b44595eafe9 ("mm, compaction: use free lists to quickly =
locate a migration source")
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> ---

Nice little cleanup.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

