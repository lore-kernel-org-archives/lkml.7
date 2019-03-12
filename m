Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA15214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OLrLXyAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCLJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:15:51 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:60098 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfCLJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:15:47 -0400
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 3DD734D421FD;
        Tue, 12 Mar 2019 12:15:43 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id I9f4hzsQqj-FhPmhv8R;
        Tue, 12 Mar 2019 12:15:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1552382143;
        bh=TRFTIMq/IA7hB/x3CMr7cyO7N9J3ZuAfmFu+BKNOG0c=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=OLrLXyAa59noapvUl7nLdz32CDX2NsOmJ7cpeHRUQB4NA8V6IYMMguk0TYnQqtXAd
         cUcYFIv8pCg97s2Y6knAgD/l0sundZ2m1rY7YrjANUojxUznaz3w0ajYL5XoV8yYIt
         u6T5fhHYzecVQE0iPMjuriLAmrfWprXPEikqu8W8=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id HHvVQer8fs-FZdKdVDE;
        Tue, 12 Mar 2019 12:15:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     paul.burton@mips.com, keguang.zhang@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Loongson-32 initial DeviceTree support
Date:   Tue, 12 Mar 2019 17:15:16 +0800
Message-Id: <20190312091520.8863-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

More works should be done after rework on clk and other drivers
accepted.

Thanks.


