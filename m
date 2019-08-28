Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9288C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9032B20644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="MU2Fx7Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfH1RsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:48:07 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33900 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfH1RsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:48:06 -0400
Received: by mail-qk1-f170.google.com with SMTP id m10so546796qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=D35SbGBlWhYpn/u3ldUwUJb3Qfls9S5/WWeqF78nIBA=;
        b=MU2Fx7Kh07hEmhYLkOxosPfDPS27ERORbzqZ3eh5zCEc40yvbWT0Eb/zAZ7tOPVDF7
         4wdqF9OfBG8XpmsWqEBtfdjO3gyN4vVk3DZuepW66EFBceqKQ0zPNR1kMoAX1fytqor3
         UD3XMN7oWyzOzHa26Z8DADGpGQZf7V3ujGSi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=D35SbGBlWhYpn/u3ldUwUJb3Qfls9S5/WWeqF78nIBA=;
        b=LOl9rJwJR/GsklNF+ch6g8AMkAsWDMpBd3O8CEeaXmenYa5wyrX05zQa7TMTkxe9tS
         j5FZjOidvRZuNM683qi5KiK0iDmYUczZacGHs3BhnapWUGJmoWkhI7uGBmR8mJc2I0iu
         k57Ez05tF45psW32mosKYE0s+qWAS0ZbIAR9/HYcUZD6O9Ktyv4H8OSdHPtZ90rGoEH9
         YPk4Pfl+j5kq8nF48b3soi2nHKMYQ3nLCLZ0gKWDSJPdO0D46a1Yrb0FLcyFJGE0Qf+2
         a3uesqplMxx1RHSQEofTr+5n3tEBkIqzLxHJ+nv5R3aXrCooio+KwPNqLU+PkAnUq+Av
         0Z7A==
X-Gm-Message-State: APjAAAWdxH0vDmoafbCRZYR5cX4sVyOY2MWWvw5i7PNHjsEhsBbAzBFJ
        SrSh5aNfX4TiGlfavorTQQATe/VEUC1aeg==
X-Google-Smtp-Source: APXvYqz9EtQEqzKRuk6DumXxdoKYmYWyg/8RdLUxpT4MSieRi5RPzW54mGUcYvGjuNmodytnXQtTbw==
X-Received: by 2002:a05:620a:12af:: with SMTP id x15mr75546qki.131.1567014484373;
        Wed, 28 Aug 2019 10:48:04 -0700 (PDT)
Received: from lauras-mbp.fios-router.home (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id m9sm1398646qtp.27.2019.08.28.10.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 10:48:03 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Date:   Wed, 28 Aug 2019 13:48:03 -0400
References: <DD187286-CEBE-44B3-A992-F84FC9C9CD26@labbott.name>
To:     linux-kernel@vger.kernel.org
In-Reply-To: <DD187286-CEBE-44B3-A992-F84FC9C9CD26@labbott.name>
Message-Id: <EDD7B30A-8A0D-45BF-BBD5-4AEFA5625FA1@labbott.name>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 9, 2019, at 2:26 AM, Laura Abbott <laura@labbott.name> wrote:
>=20
> Hello everyone,
>=20
> Friendly reminder that the TAB elections are coming soon:
>=20
> The Linux Foundation Technical Advisory Board (TAB) serves as the
> interface between the kernel development community and the Linux
> Foundation. The TAB advises the Foundation on kernel-related matters,
> helps member companies learn to work with the community, and works to
> resolve community-related problems before they get out of hand.  We
> also support the Code of Conduct committee in their mission.
>=20
> The board has ten members, one of whom sits on the Linux Foundation
> board of directors.
>=20
> The election to select five TAB members will be held at the 2019 =
Kernel Summit
> in Lisbon, Portugal September 9-11. As has been announced[2], we are =
moving to
> an electronic voting system this year. Further details about the exact =
voting
> procedures will be coming soon. Anyone is eligible to stand for =
election,
> simply send your nomination to:
>=20
> tech-board-discuss at lists.linux-foundation.org
>=20
> With your nomination, please include a short candidate statement. This =
candidate
> statement should focus on why you are running and what you hope to =
accomplish
> on the TAB. We will be collecting these statements and making them =
publicly=20
> available.
>=20
> The deadline for receiving nominations is 9am GMT+1 on September 9th =
(the first
> day of Kernel Summit). Due to the use of electronic voting, this will =
be a hard
> deadline!
>=20
> Current TAB members, and their election year:
>=20
> Jon Corbet		2017
> Greg Kroah-Hartman	2017
> Steven Rostedt		2017
> Ted Tso			2017
> Tim Bird		2017
>=20
> Chris Mason		2018
> Laura Abbott		2018
> Olof Johansson		2018
> Kees Cook		2018
> Dan Williams		2018
>=20
> The five slots from 2017 are all up for election.  As always, please
> let us know if you have questions, and please do consider running.
>=20
> Thanks,
> Laura
>=20
> [1] TAB members sit for a term of two years, and half of the board is
> up for election every year. Five of the seats are up for election now.
> The other five are halfway through their term and will be up for
> election next year.
>=20
> [2] =
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/0065=
82.html

Reminder to send in your candidate statements, the current ones are
available at=20

=
https://docs.google.com/document/d/1E3_W1c-xJMx9o2PCnKiGt3vqs-mPh77yNO4GSq=
NipOQ

Thanks,
Laura

