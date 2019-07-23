Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CD9C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EFA2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbfGWH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbfGWH5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3462307D915;
        Tue, 23 Jul 2019 07:57:24 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63B0260603;
        Tue, 23 Jul 2019 07:57:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Fixes for meta data acceleration
Date:   Tue, 23 Jul 2019 03:57:12 -0400
Message-Id: <20190723075718.6275-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 23 Jul 2019 07:57:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series try to fix several issues introduced by meta data
accelreation series. Please review.

Jason Wang (6):
  vhost: don't set uaddr for invalid address
  vhost: validate MMU notifier registration
  vhost: fix vhost map leak
  vhost: reset invalidate_count in vhost_set_vring_num_addr()
  vhost: mark dirty pages during map uninit
  vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()

 drivers/vhost/vhost.c | 56 +++++++++++++++++++++++++++++++------------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.18.1

