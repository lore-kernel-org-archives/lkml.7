Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB19C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhvuH/tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCFWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:20:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34285 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCFWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:20:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id u205so11592584ywe.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9eW18n0xcwntSVn4t2L2ScnUJjQckivdlvf+rwJIdQY=;
        b=WhvuH/tH0QnYZq64rbEhJJ0YaYHqUHb9HekDmQkT3kdtR75oZWfntlX7UBKtX4bKQH
         +IkULrpaUs2EQic369qlb+3AKtsC0gzSkbtRo8l86X+IFLYCkkkK5EeBw4iH40OPv31m
         BdJMjMa4ELbG5+M048NaFocK/u9oTXlKG3d4l7ws7d+kCAwgl0sVny1o4wIG6blKjoec
         rvEO+RTBQ/uOasF4DO23B5gu0xF8YiPa0wa+uKXnV7l2FqPaUgc9pmIVJ8MHFpT9YrM8
         jTCTLsD+ZM1lLoECznkBbdIskE7STZ9oeNHdCzqGAelMoSkPu4vGUGvsO9mAD/ArJY+S
         dPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9eW18n0xcwntSVn4t2L2ScnUJjQckivdlvf+rwJIdQY=;
        b=lu1IqJGYo7gUa2Rmdsx99VKDBiwd/F0++04Z4Z/Jtni6ctvJb2chG/WMv12gaEyQ8E
         SKzBLx6/eBj+rfph1y/yXMk6B0Zc8BwsnyKNICwIS4pLOpwINuPmWKjLOBiqiIOZBR1j
         TVVhaZtuk5xv/RBahjdwI7wqP32DNr2Kn5Ay5HdfXPVSAvHyGlgYTXQuLNmdr2WegRwA
         jIB9eEwhiUqoZQtrNVR7pJz3Cyey2euoWk1GqvDvrtiCajXLYGGMl0+mzHEzj45X46DQ
         8vv/b+gVUFJrwNbUpbmRL6+YLEU4FLxqz6XmWJHetVPIBjy/YahlB4R0A+3YrIMCUdX8
         O4rw==
X-Gm-Message-State: APjAAAW4QknL8fbk7rM95+GSo6RIySrUBJaohdbkLCM+tnP//NDfrsPS
        +kCsCnKDlwCUeZONA8/rDUw0o32mVZM66q94+5PTqSPrqg==
X-Google-Smtp-Source: APXvYqyO1eO3FYwDsz3ZiNrS4DVtRe/1ojXd6ZDm4Y2EpmzsQ6SriVh0DvYL7icaKzLmL3YG00PpJvNekErW+9jekS4=
X-Received: by 2002:a81:29cc:: with SMTP id p195mr7331837ywp.32.1551910836156;
 Wed, 06 Mar 2019 14:20:36 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Thu, 7 Mar 2019 06:20:24 +0800
Message-ID: <CANnei0FMy2UJuvoD7vKXRu6bypii02ODUAiT-3bXngGJxXG_HA@mail.gmail.com>
Subject: The NSA Makes Ghidra, a Powerful Cybersecurity Tool, Open Source | WIRED
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning from Singapore,

I am sharing some information technology news on open source
cybersecurity tools developed by the NSA.

Article: The NSA Makes Ghidra, a Powerful Cybersecurity Tool, Open Source
Author: Lily Hay Newman
News Media: WIRED.com
Date Published: 5 Mar 2019
Time Published: 9:54 PM
Link: https://www.wired.com/story/nsa-ghidra-open-source-tool/

===BEGIN EMAIL SIGNATURE===

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END EMAIL SIGNATURE===
