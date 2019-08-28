Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A24C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH1IAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:00:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:40580 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfH1IAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87A09D833D;
        Wed, 28 Aug 2019 10:00:01 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3yinYU-dRN-5; Wed, 28 Aug 2019 09:59:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DC1DCD8333;
        Wed, 28 Aug 2019 09:59:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vuMu0oR0fIL4; Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0313BD832A;
        Wed, 28 Aug 2019 09:59:40 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] dt-bindings: improve the Armada DRM bindings
Date:   Wed, 28 Aug 2019 09:59:33 +0200
Message-Id: <20190828075938.318028-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the fourth spin of a patch set that aims to complete the Armada
DRM binding documentation. The only change from the last version is the
addition of Reviewed-by tags.

What is documented corresponds to the armada-devel branch of
git://git.armlinux.org.uk/~rmk/linux-arm.git with these differencies:

* Documentation of the bus-width property of the LCDC
* The MMP2 compatible strings.

Patches to the driver for the above were sent out separately.

Lubo

