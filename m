Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4982412A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2ULD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:11:03 -0400
Received: from www17.your-server.de ([213.133.104.17]:54148 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfE2ULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:11:00 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW4uY-0004Xk-82
        for linux-kernel@vger.kernel.org; Wed, 29 May 2019 22:10:58 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW4uX-0002Lz-2g
        for linux-kernel@vger.kernel.org; Wed, 29 May 2019 22:10:58 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:10:56 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:10:56 +0200
Subject: Cocci spatch "vma_pages" - v5.2-rc1
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559160524618-2047588593-0-diffsplit-thomas@m3y3r.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_pages function on vma object instead of explicit computation.

Found by coccinelle spatch "api/vma_pages.cocci"

Run against version v5.2-rc1

P.S. If you find this email unwanted, set up a procmail rule junking on
the header:

X-Patch: Cocci
