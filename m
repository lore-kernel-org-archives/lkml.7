Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A83C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F1206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfLPPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:22:47 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:43648 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLPPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:22:45 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 10:22:44 EST
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 21E8960020
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:16:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id QUHTJEXb1be9 for <linux-kernel@vger.kernel.org>;
        Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Message-ID: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
Subject: from 5.2->5.3 lets the system run at considerably higher
 temperatures
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Mon, 16 Dec 2019 16:15:50 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

Since I've upgraded from kernel 5.2 to 5.3 my system runs a
considerably higher temperatures (like 10°C or more).
This happens even when it's effectively idle (top shows basically
nothing).
Downgrading again to 5.2 and high temperatures go away.

I did some more detailed description here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945055
but really have no clue where to start debugging.

It could be that it's somehow graphics related, as when I switch away
from X/Cinnamon to the virtual console, temperatures decrease
considerably.


Anyone else seeing something similar or having some idea how to track
this down?


Thanks,
Chris.

