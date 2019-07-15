Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A93C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5E220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy16/Wx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfGOAHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:07:24 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:34855 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfGOAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:07:23 -0400
Received: by mail-yw1-f44.google.com with SMTP id g19so6189677ywe.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z/07Xn0mprSs0akYNwVN26j/u2KE6SnLG1beAqo26v8=;
        b=uy16/Wx781TdM38+QHgBIO/myG/5AOB9VEvkRemZCFJ7lVHGjyQ0KfKy0gR2rD9qV5
         +bikIpMSGC2cSD6yB6Dg9i91HhtZ/ITP8I3EvwtSmAMLe+h3W1yNbYeniYYZQdSdnCIP
         5iLzfGzwFYCVBtKqyq1vI0ctyJNEjdmEAVCSL8l9Mkf4olGxxsslKV07/ELte4bXW/K0
         bGE/pIYoIOjGVX5U9V2F7ai+Yn/yFBsVpPVVKphCEZpB+SWZ1wDbk1x1f3e4vlvTSdUk
         4I4c0uG5pti6Mn6s1RKs8nSMGTgYBOOaKRIEMiL11TfRR1zagqvkB1iWUoi8xa1jS/+F
         KwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z/07Xn0mprSs0akYNwVN26j/u2KE6SnLG1beAqo26v8=;
        b=NXdEq/JuC9RMVGlbFGQHDftODIcoBxOYQpYQ+TvKO5i04i4DJZu5kwwvjuonAZ9xli
         FBDV/VtQxEWLtdfDz1QICVbQUikSRFczxjWL7HKl77jorbLous4PscAl6uTL4r/dmttL
         doLGRWJw4NcBiwMnnTQ6VI8vOvpmpNVoAiawxnK4dIP4riiYWRNWA6s7c0WTZZqFDsW0
         NbO4EBt7AJjFoxJymJwH60hdGZeG76BkDxbxXPao4DkJ5qVf7rBVn1nf0IPk0PODTUBb
         C1ewGLHhXQXjJl8wlOBEtmpX+5TWTynevCSxzBU5DXZNETd7BfP2PXE/mz8cpePtTI71
         5xXQ==
X-Gm-Message-State: APjAAAW+7H+HrGCdpsJDxnpVGNblnxLgs21iJGOLOkyWonMIDp6ccCNp
        tY6WILlMyvt6TqfqXm4IGE+Jamlm3SNHTRotKqGsjx0=
X-Google-Smtp-Source: APXvYqxRZr6ouHxuPbvsWNeaksfIA22ZLAcZat5n/Bka0BL72zkTJ9gHf5U7Fp63Qv+ChGgtTPiyMsVgv/iwA31JYVU=
X-Received: by 2002:a0d:f642:: with SMTP id g63mr13219075ywf.86.1563149242906;
 Sun, 14 Jul 2019 17:07:22 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Mon, 15 Jul 2019 08:07:10 +0800
Message-ID: <CANnei0GPX45o9rVU0wu9s8eg7XUn2QWUrTBDfqBPskzPTXLQpQ@mail.gmail.com>
Subject: What are the differences between cointelpro and coamdpro?
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning from Singapore,

What are the differences between cointelpro and coamdpro?



-----BEGIN EMAIL SIGNATURE-----

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

-----END EMAIL SIGNATURE-----
