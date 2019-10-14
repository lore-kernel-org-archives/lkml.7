Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40780207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfJNJJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730641AbfJNJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:09:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C447DB64B;
        Mon, 14 Oct 2019 09:09:13 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        "# 3 . 12" <stable@vger.kernel.org>
Subject: [PATCH 0/2] xen/netback: bug fix and cleanup
Date:   Mon, 14 Oct 2019 11:09:08 +0200
Message-Id: <20191014090910.9701-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One bugfix (patch 1) I stumbled over while doing a cleanup (patch 2)
of the xen-netback init/deinit code.

Juergen Gross (2):
  xen/netback: fix error path of xenvif_connect_data()
  xen/netback: cleanup init and deinit code

 drivers/net/xen-netback/interface.c | 115 +++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

-- 
2.16.4

