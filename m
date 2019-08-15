Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BDC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F4206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbfHOOgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:36:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54010 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbfHOOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:36:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so1471968wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hSLhcEGooqDQX9dEQ2Iz0HJ2gdxioh+I0vkr5E0xYqM=;
        b=uL16ibG9e4R4SCwraYxPo6GKKQVKbkTsQFp0zcVULCN1qCmOWeBcKGi1aawd9fdgOR
         g+9TV8JzqE+bEu1JyjBz44ugtJQXeyu2zyXHod3HZF0VTaiNJKgW7X8/OKJ5Y1niudWr
         VRfsXlwU6CEVbJaYnGcGTBhUGpfzVIlO+f94d8oSeD45M1n8VRxwKoAA4DicH+ZPzDUC
         xdJG3gRhSX3DXfSWFfrhB3J2oGa0ywlSb7f9rjN6ej3JHbNyTiXifkVFYYY7qslaWMOE
         aAX81fDEUS9x2k6krX4clMMpORKrWejZPVJZuSJNtHZ44lYgPy7POXl19D4LLUIiVwRd
         96/w==
X-Gm-Message-State: APjAAAWfuCMO8WKD/+0tvDoMkE2GVX6niWptF1vZYWbc+iQ4iSuQ5fOK
        r4xUx5YQ2DOPtaLd/NxndkYFCyFEfpI=
X-Google-Smtp-Source: APXvYqyng1mN/kzWAwo9k6mmDuHmTQzWXNksuIZzAaapJBv9bCyssYPg7CvIns/jwx/W/5N8vovmwg==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr3024832wma.21.1565879765976;
        Thu, 15 Aug 2019 07:36:05 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y7sm1239152wmm.19.2019.08.15.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:36:04 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 0/1] Small potential fix for shiftfs
Date:   Thu, 15 Aug 2019 16:36:02 +0200
Message-Id: <20190815143603.17127-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, people.

I was lurking at shiftfs just out of curiosity and managed to bump into
a compiler warning that is (as I suppose) easily fixed by the subsequent
patch.

Feel free to drag this into your Ubuntu tree if needed. I haven't played
with it yet, just compiling (because I'm looking for something that is
bindfs but in-kernel) :).

Oleksandr Natalenko (1):
  shiftfs-5.2: use copy_from_user() correctly

 fs/shiftfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.22.1

