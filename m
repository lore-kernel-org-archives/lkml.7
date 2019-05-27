Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34024C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F407020883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4OehAXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfE0Sud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:50:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38141 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfE0Sud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:50:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id s19so15590468otq.5;
        Mon, 27 May 2019 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/UPJRPIwxAqcYMqh+lDwMvhmFIR39N9EBpveFn3/P0U=;
        b=o4OehAXjS1nwYDdzhLHkGvwVArwzmcAxSIlUkpvfbgnDJ6qcDFoJS7mjtiNgYagV68
         HaYDEgptHDGKp+fs7ouTbBdcmo4Wvfb7Y/VYRTW7gBY00Brh6UHEqF+S4Du6M36XO9rE
         luW8RnTT8E2u/OUhGmPxMBgJGPQX1DhZ3nO3FiksbqGx5VhW3DGaAwKgffpHk/85Opat
         bowArVvXR85goWhruWmwYOZl+/2SoQGzziZkXL8uLl/ERBFtM/YLIm2WkSExw2ozRsDC
         Jd61TOlsTrmhzJ3D+gEbNrGEP4FL3HyDevV1TRCvNVBJm9AC5hSsbhCFHRrq6l6ue2F1
         iRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/UPJRPIwxAqcYMqh+lDwMvhmFIR39N9EBpveFn3/P0U=;
        b=mloObmDLCyWdQ22s1updUhAw8pRjahZLA0ei+MGf8UFutW+pvI2pzeF6XtTO97wRNI
         lW267KKthlmNLeLsvZivrOo7BcXJABq30ZZ6eXEWHNOFilTrraRAX4fEX/KLqvSTshgQ
         97GcN0hKdVIX/pyQNyEh8aHpQ2dkYEWle/fxRoowAMIql9VDDijzqFAp53+9DddNfE74
         RquK06yd3zW95Hfe4lm1xKrAVn02iQUvuByA1Q5bXGt2h+TZNx5FuacoKSYIciSc8wCo
         N8ZYMVEFCwlqe7Ou3W48LxM2NgdZytYM2PkVMKQLaejymjWqp2x7csMNKtmdjgWh9EYR
         NDeg==
X-Gm-Message-State: APjAAAUdZcD2nN/qIuiLmyU+WTZaYDg2isH0o5uCuGOEcq/lGwLruFQk
        YDIslitHFTRI2NoNyD0n9SSBWPpVG3IWvXo+39U=
X-Google-Smtp-Source: APXvYqw+7X7umORGxPn3zBCueQd3IVehTk3uOLGazLHXGvETtpKWb4bGrv4B+t9MnPKwVthX4tNhgbdWrAHKgX7EkQA=
X-Received: by 2002:a9d:69cc:: with SMTP id v12mr2651688oto.223.1558983032197;
 Mon, 27 May 2019 11:50:32 -0700 (PDT)
MIME-Version: 1.0
From:   Tord Johan Espe <tordjohanespe@gmail.com>
Date:   Mon, 27 May 2019 20:50:21 +0200
Message-ID: <CA+pK8W-OWvsdcBhJr8Prdz3Sb1AbrF6==XsT4jo0TjwAUHTouw@mail.gmail.com>
Subject: Feature request for `hid-magicmouse`
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first time I have submitted any requests to the Linux
development community, so please excuse me if I'm doing it wrong, but
after reading the docs, it seemed like the correct way to do this was
to identify the people involved with the module and send an email.

My feature request is that I think the scrolling implementation in
`hid-magicmouse.c` should take the number of currently active touches
into consideration when deciding scroll speed.

When using the Apple Magic Mouse in MacOS, scrolling is automatically
slowed down when two fingers are touching the mouse simultaneously.
This is extremely helpful for preventing unwanted scrolling when e.g.
clicking and selecting text, which is, at least for me, really
important for the overall experience. I would love it if the same
behavior could be implemented in the Linux driver.

Best regards,
Tord Johan Espe
