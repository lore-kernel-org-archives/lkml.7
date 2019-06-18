Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B5621670
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560883904;
	bh=2jKXoqA5El3xMfvg0tJ7PgJZZ2I9VARYV5no+Sb5XgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOsGizYJs4CVBqign0QZo7Dh7eqjdLjH7QmyFYKqjX6WRtPTkOAIoSsKrtyBYyzWu
	 dDdV8OhWOAn5Tl685kYMpLyOSBdmnR1ZARg0e0tefFSLO48LhdR44zamsFfkQf6nlc
	 4JowMeef3g+mP8OR3bqzxezZQaY9k189Y+mkV+Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfFRSvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:51:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfFRSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WEeSkfNlVjEZ8zE/kIdUT5en1C0xrZgmdnZZh07bcGQ=; b=OHOX/43xK2MGJ1Tb1T2SKNnKU/
        nkynHEPxsjayML718hjXEUx+JgT6ClMA5K7yKIqVz+Mu9McbWVlET2hHEQ7oCEYGcRRef16CCxYW0
        OqusDHA7Gl92P/R/QdKQEbrymJv/Z8hheXd1UUNFT4eIKkQ4Sa32Z6TU5mz3KiYZXCEzsidFtAo6r
        Qk3Ulwcq9Y+fllhsWIcjHRBA7qWnO7I+gtlelZlCqXGSoY/kVRNwvPKQS79eCWINEaX9vuhFP1TNI
        8JnFCFMxJ2Pi5kjSNLrHGCVZQrsV/SnvR3oopcpueM6HhLsBomhoVDEPPiBqFB9/93rZXsFg1hdZZ
        7B342NXw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJCa-0006RI-0g; Tue, 18 Jun 2019 18:51:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJCW-0006UB-An; Tue, 18 Jun 2019 15:51:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 2/6] docs: trace: add a missing blank line
Date:   Tue, 18 Jun 2019 15:51:18 -0300
Message-Id: <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx expects a blank line after a literal block markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/trace/kprobetrace.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3d162d432a3c..caa0a8ba081e 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -228,6 +228,7 @@ events, you need to enable it.
 
 Use the following command to start tracing in an interval.
 ::
+
     # echo 1 > tracing_on
     Open something...
     # echo 0 > tracing_on
-- 
2.21.0

