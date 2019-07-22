Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73275C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8582190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817138;
	bh=UgVydyRS3CfKa+Xmlw+o8J0uULffuzL++M23zJDPi2c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dERKm7D+cOWyI3cpK+wZ/bC8FTsmP8SK0NeoIkj3sRUL6B0Dx1iJSlXbO+8eyecmy
	 6sYTgatr6tTrsMjl7KE0kM5ifXN24KV/QBiVOwAjVA9K9PZfNSkWjV3nZd4sY2iBG0
	 dKCXyfWHhzobUqWkpI6VW71TPoieG42QNcz9lHsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfGVRi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfGVRi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:38:56 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B42D21901;
        Mon, 22 Jul 2019 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817135;
        bh=UgVydyRS3CfKa+Xmlw+o8J0uULffuzL++M23zJDPi2c=;
        h=From:To:Cc:Subject:Date:From;
        b=lTb9ODpvGK1mg97VGBQy3prlEmZuZiLU0FFvJWkXMqnF5s7VAgNnF4QVtnQGvAiZM
         ugqRnixVNr1SG6x10yVVXyG/wkPr3mlJZSLwlRdRaYwtZuXICG1AI4bayRC814bgH/
         HCGkNi25wg04F6LVItZPmgYVFVXLNSK+ApDoerDI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon, 22 Jul 2019 14:38:02 -0300
Message-Id: <20190722173839.22898-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

