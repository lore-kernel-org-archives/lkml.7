Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D533C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F72080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfIEM1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfIEM1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93EF53001836;
        Thu,  5 Sep 2019 12:27:44 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA1775D9E2;
        Thu,  5 Sep 2019 12:27:37 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@mellanox.com, aarcange@redhat.com, jglisse@redhat.com,
        linux-mm@kvack.org
Subject: [PATCH 0/2] Revert and rework on the metadata accelreation
Date:   Thu,  5 Sep 2019 20:27:34 +0800
Message-Id: <20190905122736.19768-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 12:27:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Per request from Michael and Jason, the metadata accelreation is
reverted in this version and rework in next version.

Please review.

Thanks

Jason Wang (2):
  Revert "vhost: access vq metadata through kernel virtual address"
  vhost: re-introducing metadata acceleration through kernel virtual
    address

 drivers/vhost/vhost.c | 202 +++++++++++++++++++++++++-----------------
 drivers/vhost/vhost.h |   8 +-
 2 files changed, 123 insertions(+), 87 deletions(-)

-- 
2.19.1

