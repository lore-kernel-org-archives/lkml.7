Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BEC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7082133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFZO3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:29:15 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:57229 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfFZO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:29:15 -0400
Received: from h2730561.stratoserver.net (h2730561.stratoserver.net [85.214.29.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 771761F42E;
        Wed, 26 Jun 2019 16:29:12 +0200 (CEST)
From:   =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: staging: rts5208: Two patches to improve code style
Date:   Wed, 26 Jun 2019 16:28:55 +0200
Message-Id: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches improve the code style in the rts5208 staging
driver. Many other style issues cannot be resolved without much more
extensive refactoring.


