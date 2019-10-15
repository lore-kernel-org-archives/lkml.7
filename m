Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B663ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9B217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfJOIPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:15:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728560AbfJOIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:15:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B968AAE7F;
        Tue, 15 Oct 2019 08:15:17 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:15:34 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dmi fix for v5.4
Message-ID: <20191015101534.278375b9@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem fixes for Linux v5.4 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---------------

Jean Delvare (1):
      firmware: dmi: Fix unlikely out-of-bounds read in save_mem_devices

Thanks,
-- 
Jean Delvare
SUSE L3 Support
