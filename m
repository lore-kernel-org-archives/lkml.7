Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA7C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED08227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dFlkIYFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGWXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:30:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17344 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfGWXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:30:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d37988a0000>; Tue, 23 Jul 2019 16:30:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 16:30:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 16:30:20 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 23:30:20 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Jul 2019 23:30:20 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d37988b000b>; Tue, 23 Jul 2019 16:30:19 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/2] mm/hmm: more HMM clean up
Date:   Tue, 23 Jul 2019 16:30:14 -0700
Message-ID: <20190723233016.26403-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563924618; bh=FDbwFDSZuMyIknDuhtiS91edYJrPm1xbqLmLfcav/Qw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=dFlkIYFBEahjwsEE41Zja3tD83QFXyCZwYtuwUf3HBcIKWr/C8XVrbvjMIQm1+Lo0
         Vj9TsJdpNOTAuaK1b1PgiMTlip9kDy1Hfro5q2mEpL2opgUnegJ+1Fm/F6MF2PATXh
         Gd4P7ZaDfwpKawPOmovjf/1lrYBxgpvagSXMctDX0o22gStsuEe+M9kyU+x8hKXAqg
         ZJ4W7J3TKLOk1fnttYAcYFo9E0VkpNcMBwcb3tYKJfDKaYa+xUks4qBrTaaHRcUxac
         s1QP7P4RLQPRM52ylO0zWpcoLzP69Zz9JWkIk20IcPGb5KoSw3Lgd9zqvwWvb7mbg5
         uywZaQAcOHSBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two more patches for things I found to clean up.
I assume this will go into Jason's tree since there will likely be
more HMM changes in this cycle.

Ralph Campbell (2):
  mm/hmm: a few more C style and comment clean ups
  mm/hmm: make full use of walk_page_range()

 mm/hmm.c | 231 +++++++++++++++++++++----------------------------------
 1 file changed, 86 insertions(+), 145 deletions(-)

--=20
2.20.1

