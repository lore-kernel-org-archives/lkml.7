Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE3ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7EB2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbfJPBbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:31:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:60917 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfJPBbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:31:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,302,1566889200"; 
   d="scan'208";a="279378776"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO localhost.localdomain) ([10.249.68.79])
  by orsmga001.jf.intel.com with ESMTP; 15 Oct 2019 18:30:53 -0700
From:   Zhu Lingshan <lingshan.zhu@intel.com>
To:     mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [RFC 0/2] Intel IFC VF driver for vdpa
Date:   Wed, 16 Oct 2019 09:30:48 +0800
Message-Id: <20191016013050.3918-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
 
This series intends to introduce Intel IFC VF NIC driver for Vhost
Data Plane Acceleration.
 
Here comes two main parts, one is ifcvf_base layer, which handles
hardware operations. The other is ifcvf_main layer handles VF
initialization, configuration and removal, which depends on
and complys to vhost_mdev https://lkml.org/lkml/2019/9/26/15 
 
This is a first RFC try, please help review.
 
Thanks!
BR
Zhu Lingshan


Zhu Lingshan (2):
  vhost: IFC VF hardware operation layer
  vhost: IFC VF vdpa layer

 drivers/vhost/ifcvf/ifcvf_base.c | 390 ++++++++++++++++++++++++++++
 drivers/vhost/ifcvf/ifcvf_base.h | 137 ++++++++++
 drivers/vhost/ifcvf/ifcvf_main.c | 541 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1068 insertions(+)
 create mode 100644 drivers/vhost/ifcvf/ifcvf_base.c
 create mode 100644 drivers/vhost/ifcvf/ifcvf_base.h
 create mode 100644 drivers/vhost/ifcvf/ifcvf_main.c

-- 
2.16.4

