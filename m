Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A721ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4128B2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1llG5ZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfJNOOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:14:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44076 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfJNOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:14:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so16756604ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mjzIKc6ltaFJvBIPmNJN5gNGqiFBXaLXgBZ1YTgCVkE=;
        b=o1llG5ZPXBEyLJwkn+leErkopF2YhcwoT5o6VHSGzUJeP2mXb0VZTUBcgqpqRoB/SX
         JMmuWHO8oMoUUKOdGlFfcW2kZ7GU24LzWjwS1c1UlDOPM7CBHBUYDM7LB5wTElxV3aaQ
         qFRsmIUfpgRrBdpyforuGF+rhI2dhGT87OhhP1142pXrFiKzXPqYTuGazzOWtRAJ3z0K
         AMBvtqKRezFZoE59VpUs2g6bwKdyR5CUch+ZGsd/5DmsUnGb+jAbUa3Mxq80ge0TTFUB
         fgrc2ejlIaNwEdukWwCrrL7yyYbB2dpatVwGqbqGbdbnYVR+J1VvsAGVok7yduxKhRQE
         bvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mjzIKc6ltaFJvBIPmNJN5gNGqiFBXaLXgBZ1YTgCVkE=;
        b=apqAxNgzPL1KfgIGqgp6fQ24XS9s8m4cLzsroaMaVPSDcBiLkMrUl4LEex9H0suKzb
         42Nkk85kx8L5h5hSaL7M1Z7ppatjJaYtgbp4Eij8aoBoOigmcO7Edg3olgtXgFrQeYSn
         1WlaDC5ZH2OCrNF3xzkMYSmbAfmKMdKsmPBcO9haKxdK4uOgj80Bxo2TaxTbHOs4BSKR
         mIa53jwZQ1sdK5Kijd4f23YK7uanB2vJfAmhhVgoJrXtX3/Cwqdl6rBQA/y/FUGbOJ2V
         K99KtsKW1vdxaSaxyf9IQGyZf0zFbfDm90KemdxZw9aFqQtaq91PD6K9wefyVKjbkYRj
         hUUw==
X-Gm-Message-State: APjAAAUrHeDyLmr3hrGTAeBIVkgSNDMyzDV7J3AM7nW8HvG/JWMO9Fb7
        4SC0NeEvrH0jMzq7UCK6G0dMrDvTZXn7/TaQ5EECPW8s7s0=
X-Google-Smtp-Source: APXvYqzXMxD8MoLwlGSvu/DO3QnfWNF8lwNzQu0R2Gre2ptQhmbyTTnpIrwj2nlY+31+syNh/ZYE2l+YoenfD/fp8nc=
X-Received: by 2002:a05:651c:1042:: with SMTP id x2mr19596482ljm.127.1571062459632;
 Mon, 14 Oct 2019 07:14:19 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming.smartphone@gmail.com>
Date:   Mon, 14 Oct 2019 22:14:05 +0800
Message-ID: <CA+5xKD7OcGuZk_Y09xbH3igvv8+yQf07tp0Qv7gQV_q8+O9SKw@mail.gmail.com>
Subject: I am of the opinion that Singaporean Mr. CHEONG WEI CHANG is also a
 TARGETED INDIVIDUAL (TI)
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <teo.en.ming.smartphone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I am of the opinion that Singaporean Mr. CHEONG WEI CHANG is
also a TARGETED INDIVIDUAL (TI)

Below is a non-exhaustive list of news articles on Singapore Citizen
Mr. CHEONG WEI CHANG.

[001] News Article: Man's suit against Lee Hsien Loong alleging woes
caused by PM's 'department' thrown out
News Platform: Yahoo! News Singapore
Link: https://sg.news.yahoo.com/mans-suit-lee-hsien-loong-alleging-woes-cau=
sed-pms-department-thrown-124212754.html

[QUOTE] In all, Cheong enclosed three volumes of documents comprising
miscellaneous photos relating to a variety of his supposed woes. The
photos and their captions related to topics ranging from failed job
interviews and errors in finance textbooks to health problems.

...snipped...

Cheong said Lee =E2=80=9Cand/or his department=E2=80=99s regulations concer=
n (sic) my
health and activities=E2=80=9D, and that Lee =E2=80=9Cdid not address my co=
ncerns on
the regulations of activities when I asked for the regulations of
activities to stop=E2=80=9D. [UNQUOTE]

[002] News Article: Man Sues PM Lee For Blood In Stools; Case Thrown
Out Of Court Twice
News Platform: Mustsharenews.com
Link: https://mustsharenews.com/blood-stools-pm-lee/

[QUOTE] Of bloody stools & failed interviews

...snipped...

The second was a failed job interview at Citibank. [UNQUOTE]

[003] News Article: Plaintiff tries to sue Lee Hsien Loong, claims
Prime Minister made him shit blood
News Platform: The Independent Singapore
Link: http://theindependent.sg/plaintiff-tries-to-sue-lee-hsien-loong-claim=
s-prime-minister-made-him-shit-blood/

[QUOTE] A local man has failed in his attempt to sue Singapore Prime
Minister Lee Hsien Loong for imposing =E2=80=9Cregulations=E2=80=9D on his =
life that
seems to hamper the plaintiff=E2=80=99s quality of life.

...snipped...

In the judgment on the case that was released on the Supreme Court=E2=80=99=
s
website last Friday, it appears that the man, Mr Cheong Wei Chang,
tried to sue PM Lee in his capacity as the head of Government for
imposing =E2=80=9Cregulations of activities=E2=80=9D on him that =E2=80=9Cc=
oncern my health
and activities.=E2=80=9D

...snipped...

Revealing that the volumes pointed to a wide variety of topics such as
failed job interviews, health issues and errors in finance textbooks,
judicial commissioner Valerie Thean provided three examples of the
issues Mr Cheong attributed to PM Lee, in the judgment. [UNQUOTE]

It appears that Singapore Citizen Mr. Turritopsis Dohrnii Teo En Ming
has symptoms very similar to that of Singapore Citizen Mr. CHEONG WEI
CHANG.





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
