Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A84C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A029216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NQH0KqyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfHASOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:35 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39678 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHASOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:31 -0400
Received: by mail-pl1-f170.google.com with SMTP id b7so32606818pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTSTyTo6evUeD9vN87wB9846b+0jKcxNJYQscwXw5sw=;
        b=NQH0KqyW9HA6J8qu3jcP/EcZP9+Dt9SdZyCsiW/AH/W8wqz+USQvcaQfYUzlzSfbgR
         Ij1IN+7e4qXHO9NTK5EEep7/oiPPG9WvtR5+dlme1r519lqOFVLuY+ufmMd87n1H7ibc
         r8gKQ77iXmZcx7oiwKNwdqgzKpHPds6DiX+Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTSTyTo6evUeD9vN87wB9846b+0jKcxNJYQscwXw5sw=;
        b=SdnUJm53d7wcCf3ej4rZO8lzv495zHogjMW0SnKvG6YloU1YXdVtVSiVhHZJ26AZxH
         V6lkwwGzCYutPxI/x2siiPazspOxRxykfUDDIYAooRUiewbSz/nGWUDAlW0WbX5sCqJd
         Ts2DXo/9FEaNCZCE0PUDdeV9b+zusCsLttryK89DN5+/Xmlx9fWfDFwFee5tHGgKvXO8
         zDtn59DK9dzGicZPTNaHdTW815zS8liAv1EF++auikQxMz+EkgVZbzU4MIVcPussJ5+j
         xv2TojUN23J03c1XQSZVntLR4EJ7FhIrINMlZgTtWpeD7rDvg+iWysF2we6ewBkEBpzV
         7+GA==
X-Gm-Message-State: APjAAAVsALcALpXlyZCqUV++N7jrfsAN7TkyvygBf9SAMEfX4Lx/9s7x
        oRYLxmri+MKSWYBdMKSL5lPdaNMC
X-Google-Smtp-Source: APXvYqwU+ZiW94iwKYYnEkVtZjmggBfKvTHyujaf8wwby2Y6JxMZ4Hc6tBu7MfZDlVzlfwfMSP9z2Q==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr121322215pls.341.1564683270622;
        Thu, 01 Aug 2019 11:14:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 6/9] docs: rcu: Increase toctree to 3
Date:   Thu,  1 Aug 2019 14:14:08 -0400
Message-Id: <20190801181411.96429-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These documents are long and have various sections. Provide a good
toc nesting level.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 94427dc1f23d..5c99185710fa 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -5,7 +5,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 3
 
    rcu
    listRCU
-- 
2.22.0.770.g0f2c4a37fd-goog

