Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E5C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACB1206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568630513;
	bh=8Lad/z99ogBj1xN6N+8h5kl/jayrtAAGiokaOeSOEas=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Dj8mCPU2bsjai/tCYnEeDXzZQeeIFwSWDxb33N0QBNyQlwCxeMjGFppm7ItuA026U
	 iNPq9hxs8hjL0G8vCQg5BtSLl6bID3N6Ujmgim2wC7hLR0cXus2mG1a1kNjcvjgidP
	 cAHD3FFXA2E18U9wLNIFrKdvma36JcAgefDEyXGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfIPKlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfIPKlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:41:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E69206A4;
        Mon, 16 Sep 2019 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568630510;
        bh=8Lad/z99ogBj1xN6N+8h5kl/jayrtAAGiokaOeSOEas=;
        h=Date:From:To:Cc:Subject:From;
        b=QKCM+GcBTYZR0fuw3RuIu+62WS+0f5kh6rVtuDNzyApFDhg+OMpsdjsllpRTBwz/w
         /qGghW0lVVuDSDiiP3kWm/lZ9KdxFreDP9p4bp91uTqiGPW7xOTDRkial5k05/EL5M
         gRwuTbaHW3okkcT0al/yOoDOj+U8pKxYPO/wsZGU=
Date:   Mon, 16 Sep 2019 12:41:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.193
Message-ID: <20190916104148.GA1386623@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.193 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                        |    2 +-
 arch/x86/boot/compressed/misc.c |    1 +
 arch/x86/boot/compressed/misc.h |    1 -
 drivers/clk/clk-s2mps11.c       |    2 +-
 drivers/vhost/test.c            |   13 +++++++++----
 drivers/vhost/vhost.c           |    4 ++--
 include/net/xfrm.h              |   17 +++++++++++++++++
 net/key/af_key.c                |    4 +++-
 net/packet/af_packet.c          |    2 +-
 net/xfrm/xfrm_state.c           |    2 +-
 net/xfrm/xfrm_user.c            |   14 +-------------
 scripts/decode_stacktrace.sh    |    2 +-
 sound/pci/hda/hda_auto_parser.c |    4 ++--
 sound/pci/hda/hda_generic.c     |    3 ++-
 sound/pci/hda/hda_generic.h     |    1 +
 sound/pci/hda/patch_realtek.c   |    2 ++
 16 files changed, 45 insertions(+), 29 deletions(-)

Cong Wang (1):
      xfrm: clean up xfrm protocol checks

Dave Jones (1):
      af_packet: tone down the Tx-ring unsupported spew.

Greg Kroah-Hartman (1):
      Linux 4.4.193

Nathan Chancellor (1):
      clk: s2mps11: Add used attribute to s2mps11_dt_match

Nicolas Boichat (1):
      scripts/decode_stacktrace: match basepath using shell prefix operator, not regex

Takashi Iwai (2):
      ALSA: hda - Fix potential endless loop at applying quirks
      ALSA: hda/realtek - Fix overridden device-specific initialization

Tiwei Bie (1):
      vhost/test: fix build for vhost test

Zhenzhong Duan (1):
      x86, boot: Remove multiple copy of static function sanitize_boot_params()

yongduan (1):
      vhost: make sure log_num < in_num

