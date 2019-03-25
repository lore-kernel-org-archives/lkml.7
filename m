Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C054B20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfCYVZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:25 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:50084 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730199AbfCYVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E776B181D341F;
        Mon, 25 Mar 2019 21:25:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pot74_119995f518f3e
X-Filterd-Recvd-Size: 2735
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:25:20 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Bad file pattern in MAINTAINERS section 'I3C SUBSYSTEM'
Date:   Mon, 25 Mar 2019 14:25:19 -0700
Message-Id: <20190325212519.26558-1-joe@perches.com>
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

	7333	I3C SUBSYSTEM
	7334	M:	Boris Brezillon <bbrezillon@kernel.org>
	7335	L:	linux-i3c@lists.infradead.org
	7336	C:	irc://chat.freenode.net/linux-i3c
	7337	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
	7338	S:	Maintained
	7339	F:	Documentation/ABI/testing/sysfs-bus-i3c
	7340	F:	Documentation/devicetree/bindings/i3c/
	7341	F:	Documentation/driver-api/i3c
	7342	F:	drivers/i3c/
	7343	F:	include/linux/i3c/
-->	7344	F:	include/dt-bindings/i3c/

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'include/dt-bindings/i3c/':

commit 4f26d06669619b960aa7246378dcdf1690c97384
Author: Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Fri Mar 23 11:38:16 2018 +0100

    MAINTAINERS: Add myself as the I3C subsystem maintainer
    
    Create an entry for the I3C subsystem and mark it as maintained by me.
    There's no official git repository, patchwork instance, mailing list or
    website yet, but this will be added after the subsystem has been
    accepted.
    
    Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'include/dt-bindings/i3c/' was found
