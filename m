Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A5EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673C5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfDJNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:19:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33780 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfDJNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:19:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so2800868qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=otb3FCXOqSdtQ3jmIbrSoFdp5BqWCt94sI/8nxoGClk=;
        b=VSzNxg6zGsh7Rd+rAQ9b9kBmmP1RZFJXSTjVXYJ0Rmb9O2wXEQrI38BDD1pIjirJKp
         s6GjggWMEwbUyha8e0aHicgfktXNnBcWDwe24LI78sbYl96Ys6z4cjzu54DDG3HxKw1s
         n/z5++zVongoyDVls2qLTig02jRZWMFYnUOR+1BThx8I05zrU4UI7vyjEO3b4BRohgfv
         0JwUk86PImDKia8aUweBHiuNQnZr4gXjLhzmWVByW6v7ThGsHD4Rm+WQVjonrx+zcNoR
         Z5AkeBOatSmJP2oITPxRKJvw4sfXdwXKGJya4T3G1DPPLq+bLSciSfnG5Rs1J2/4Qd35
         5W7g==
X-Gm-Message-State: APjAAAUBJuw1mfgVC0MXLdnpCfALTOyyjWhVDFkgZu5LAFNzAbTfN1Kf
        dDJY0YYxtFXgp9CMPn9kY5vXHg==
X-Google-Smtp-Source: APXvYqxcZz7R7ru5MkC0PkqkkdulO+vFFCrQvBuWCZ1XRFnrOHLgM2hBkXx4AEzCaTj0yRH1MKbB8w==
X-Received: by 2002:aed:3e9b:: with SMTP id n27mr35357251qtf.192.1554902340677;
        Wed, 10 Apr 2019 06:19:00 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id r201sm19297398qke.37.2019.04.10.06.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:18:59 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:18:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, cohuck@redhat.com, longpeng2@huawei.com,
        mst@redhat.com
Subject: [PULL] virtio: fixes
Message-ID: <20190410091858-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cf94db21905333e610e479688add629397a4b384:

  virtio: Honour 'may_reduce_num' in vring_create_virtqueue (2019-04-08 17:05:52 -0400)

----------------------------------------------------------------
virtio: fixes, reviewers

Several fixes, add more reviewers to the list

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Longpeng (1):
      virtio_pci: fix a NULL pointer reference in vp_del_vqs

Michael S. Tsirkin (1):
      MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi

 MAINTAINERS                        | 15 ++++++++++++++-
 drivers/virtio/virtio_pci_common.c |  8 +++++---
 drivers/virtio/virtio_ring.c       |  2 ++
 include/linux/virtio_ring.h        |  2 +-
 4 files changed, 22 insertions(+), 5 deletions(-)
