Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07588C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfCYV1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:14 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:41777 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730511AbfCYV1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 024EB182CED5B;
        Mon, 25 Mar 2019 21:27:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ghost66_2196121266b06
X-Filterd-Recvd-Size: 3843
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:10 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Pismenny <borisp@mellanox.com>, netdev@vger.kernel.org,
        Ilan Tayari <ilant@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Bad file pattern in MAINTAINERS section 'MELLANOX ETHERNET INNOVA IPSEC DRIVER'
Date:   Mon, 25 Mar 2019 14:27:09 -0700
Message-Id: <20190325212709.26906-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	9887	MELLANOX ETHERNET INNOVA IPSEC DRIVER
	9888	R:	Boris Pismenny <borisp@mellanox.com>
	9889	L:	netdev@vger.kernel.org
	9890	S:	Supported
	9891	W:	http://www.mellanox.com
	9892	Q:	http://patchwork.ozlabs.org/project/netdev/list/
-->	9893	F:	drivers/net/ethernet/mellanox/mlx5/core/en_ipsec/*
	9894	F:	drivers/net/ethernet/mellanox/mlx5/core/ipsec*

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/net/ethernet/mellanox/mlx5/core/en_ipsec/*':

commit 547eede070eb981f1442e494f08f4567dcf1d1c7
Author: Ilan Tayari <ilant@mellanox.com>
Date:   Tue Apr 18 16:04:28 2017 +0300

    net/mlx5e: IPSec, Innova IPSec offload infrastructure
    
    Add Innova IPSec ESP crypto offload configuration paths.
    Detect Innova IPSec device and set the NETIF_F_HW_ESP flag.
    Configure Security Associations using the API introduced in a previous
    patch.
    
    Add Software-parser hardware descriptor layout
    Software-Parser (swp) is a hardware feature in ConnectX which allows the
    host software to specify protocol header offsets in the TX path, thus
    overriding the hardware parser.
    This is useful for protocols that the ASIC may not be able to parse on
    its own.
    
    Note that due to inline metadata, XDP is not supported in Innova IPSec.
    
    Signed-off-by: Ilan Tayari <ilant@mellanox.com>
    Signed-off-by: Yossi Kuperman <yossiku@mellanox.com>
    Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
    Signed-off-by: Boris Pismenny <borisp@mellanox.com>
    Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>

 MAINTAINERS                                        |  10 +
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |  12 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 415 +++++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  78 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  14 +
 include/linux/mlx5/mlx5_ifc.h                      |   8 +-
 include/linux/mlx5/qp.h                            |  14 +-
 9 files changed, 552 insertions(+), 4 deletions(-)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/net/ethernet/mellanox/mlx5/core/en_ipsec/*' was found
