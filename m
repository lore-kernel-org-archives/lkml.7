Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D00C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7492133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfHNSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:36:38 -0400
Received: from mail-a05.ithnet.com ([217.64.83.100]:42786 "EHLO
        mail-a05.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:36:38 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 14:36:36 EDT
Received: (qmail 8432 invoked by uid 0); 14 Aug 2019 18:29:54 -0000
Received: from skraw.ml@ithnet.com by mail-a05 
 (Processed in 2.051755 secs); 14 Aug 2019 18:29:54 -0000
X-Virus-Status: No
X-ExecutableContent: No
Received: from unknown (HELO ithnet.com) (217.64.64.14)
  by mail-a05.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 14 Aug 2019 18:29:52 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date:   Wed, 14 Aug 2019 20:29:51 +0200
From:   Stephan von Krawczynski <skraw.ml@ithnet.com>
To:     linux-kernel@vger.kernel.org
Subject: VLAN tag stacking with bridge/tap device ?
Message-ID: <20190814202951.20d7dff1@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I try to do a setup with qemu and tap devices attached to bridges where 802.1Q
vlan packets that are tag stacked are running through the tap device/bridge
where the outer tag is stripped. But it seems on the way back out of
qemu/guest and back through the tap and bridge no additional vlan tags are
added back.
The very same setup with only one vlan tag that is stripped and added back
works as expected. Is there something in the tap device or bridge code that
prevents stacking? Can this be done by configuration or by additional coding
in the tap or bridge?

-- 
Regards,
Stephan

PS: please add me as cc in reply
