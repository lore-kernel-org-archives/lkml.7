Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DBEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E2D2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="fHEi8ItR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405659AbfHIG0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:26:23 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34352 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfHIG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:26:23 -0400
Received: by mail-wm1-f41.google.com with SMTP id e8so5205334wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=vlxK8xDF4eNfC+oTwctLwIffFn6g/NeBo57WGK7Q3gU=;
        b=fHEi8ItRXEH/I4wxHxtW4ITnNFkpvjVZZMGFKyggEvNZzVRgHk1fxjtYu/gomMxN/D
         B48LnR5SmYQhOr9i4hZadsH8OodwBgRbKoMPjN++kN1r9rNI2sERCqvZHmADKjSZh93D
         Yagfuj5oWKal7SxL8D0C1juwSSbv8nA9weBmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=vlxK8xDF4eNfC+oTwctLwIffFn6g/NeBo57WGK7Q3gU=;
        b=XYPdpXAJO+uP+yoXyUB5PnM1WHIFEa6XyXGq0pNjqPSggs2/uesXMGzcwPJ7astmAQ
         oYe9E5vW+b5uFopj5Hgmr8duX9UNTunSv6/XIkll/9OhyPPbOwQvaL1H7of1XqdDHLYb
         kHIUrYh0hCZIWf5og5hT4Z67l1VeYK7JJPb5ge7+9SZd2AqfH53Mu8wO51J2EkxXVouC
         r04BI3zmum5hxi7NmJeBKj4nwvdV6yBH+gYEFnvyO/8pJ8IgRSC21Iwglk9Z9ZkWqW0m
         il4EGEkoP7b3q27H/opiQMyW+fYaoMMa3Q2ppyteSrOj/2bRcrBOl4wG6eq5jW7bnNHS
         TK7g==
X-Gm-Message-State: APjAAAUlxosd6mogSzSV0u429yx7Fwv9RyNZfFiD0l+2ApUquN4AIeoC
        L86alvPC3yaujTXEusN7TceJ3EF872Lr1A==
X-Google-Smtp-Source: APXvYqy+VHCMBB/YKlRF1ljpLoc+8qx7vl52S3hq1JbUuAtgC79mFPsq+3d7V9FI2wEu5atQJj6U0g==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr8919055wmc.95.1565331980471;
        Thu, 08 Aug 2019 23:26:20 -0700 (PDT)
Received: from [192.168.200.9] ([193.68.39.228])
        by smtp.gmail.com with ESMTPSA id i66sm6698428wmg.2.2019.08.08.23.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 23:26:19 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Message-Id: <DD187286-CEBE-44B3-A992-F84FC9C9CD26@labbott.name>
Date:   Fri, 9 Aug 2019 02:26:18 -0400
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Friendly reminder that the TAB elections are coming soon:

The Linux Foundation Technical Advisory Board (TAB) serves as the
interface between the kernel development community and the Linux
Foundation. The TAB advises the Foundation on kernel-related matters,
helps member companies learn to work with the community, and works to
resolve community-related problems before they get out of hand.  We
also support the Code of Conduct committee in their mission.

The board has ten members, one of whom sits on the Linux Foundation
board of directors.

The election to select five TAB members will be held at the 2019 Kernel =
Summit
in Lisbon, Portugal September 9-11. As has been announced[2], we are =
moving to
an electronic voting system this year. Further details about the exact =
voting
procedures will be coming soon. Anyone is eligible to stand for =
election,
simply send your nomination to:

tech-board-discuss at lists.linux-foundation.org

With your nomination, please include a short candidate statement. This =
candidate
statement should focus on why you are running and what you hope to =
accomplish
on the TAB. We will be collecting these statements and making them =
publicly=20
available.

The deadline for receiving nominations is 9am GMT+1 on September 9th =
(the first
day of Kernel Summit). Due to the use of electronic voting, this will be =
a hard
deadline!

Current TAB members, and their election year:

Jon Corbet		2017
Greg Kroah-Hartman	2017
Steven Rostedt		2017
Ted Tso			2017
Tim Bird		2017

Chris Mason		2018
Laura Abbott		2018
Olof Johansson		2018
Kees Cook		2018
Dan Williams		2018

The five slots from 2017 are all up for election.  As always, please
let us know if you have questions, and please do consider running.

Thanks,
Laura

[1] TAB members sit for a term of two years, and half of the board is
up for election every year. Five of the seats are up for election now.
The other five are halfway through their term and will be up for
election next year.

[2] =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html=
