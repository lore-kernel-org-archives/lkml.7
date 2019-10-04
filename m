Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C118CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F4E20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AM/+rTiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfJDRB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:01:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:53509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDRB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570208501;
        bh=rMXMlquVolHdzq3iMBKYhvNEjZXTAD9wUTb0Zleuwe4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AM/+rTiHGXkxTHTXipWBFZehlfnX39NLfa93IG8q7gWiH2wZV2sltpdEBeTDZ9pEw
         FqaQlhIFL25iREhQ9PpRH3Lyv/1yZSLjFLd1qIuarPPLha+18pC6uDT78CiLY7330w
         iFi9FNh8sJuYHce6epCyPhJnjyf9Jp/kb9wUv3xw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.25.131]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1huUBp0tnM-00vS1g; Fri, 04
 Oct 2019 19:01:41 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: pti_intel_mid: Enable syntax highlighting for C code block
Date:   Fri,  4 Oct 2019 19:01:19 +0200
Message-Id: <20191004170124.13543-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gciz2EElTa6KfXaWKUA+P3Az3klSD2od1ANJqJFKJ8B3e0BMfkt
 eKgd9hwRLo95M3C6jcfKjXn51vXguSDl40z44+7CUQ8lAjaGfGhePBTm+daNb52T/5xW6aC
 FKLWaMEvHC1A0N5tDvWdTQB4229ZEwYDwNUupjdzcZtf8zsWpaHd1UvREMU93JZdx7IINRd
 5Q7HISLEB7lhFvNPkY/6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6+AqMcmrvRM=:IFG58wDC1/JOLCHxgF/HoV
 7olDa2e7dZQj13GaG8UJQ8oQhDUgEHLxVFvKMhZ8etpc1ZCFCZ3LwBaz9VWFkny5ifiAfjM21
 dgs0tSfJ73oNR9rSs5mFd7zlLIBKZ8DEy7RI9oINHWOR4I+4HNMK6xNMrAWOXdxi4wEb0czwV
 pKH3cTB1O4iixfh7xDUHEowk7WvejWlEtlq7U7b7APne3EF3irs3tG2xqpAl3cCGY+orMq8AG
 5+RVdL4BdFfEs7IjcgqOlgNUUMutoeeNgNq+5gaYxkIFWgZM/M/VmstxFNhNxBnSEsC4SGTfg
 VyIt6h59xNPs/47x4DZba6CetV1t2uUhrrfs3GGndLIduHLrGeyNd3cggAW/hUpq/8bopooIc
 bqMVwg+r3BNm92Yt9fozfUJyYJqByyfiWk2aye5BrsJoQ9SFwL5MYi+DV8qHTmb5CAXMrQCp6
 zxweL6v3tmD8sODxpR0TJLjM0bGYB1VKzrR/qvNxFco7pADExCMbdpkz8ZBPV+Fzw0x//Shnq
 JmLIfne+3WbzGAPmFKEfVXqNZZcvHUBbnCNNJQ2bk063V6V/sDhQDPjJCrbsl7NHYDtgJUVsC
 ZtI9ImfaNIloUaWsYzzNjv8oHMEIJ5TWpiRsPWYlwinLwpEkrcd0vZWVm272H5wExK1RKq1BW
 CjwMd9XRC31OFptIsHb+hz0vJAixj4jzRjmw2BfaaXagwsS/vI1boRa+j9a2gyW9A/1PLAGOz
 BYcfXmsa2FNx+LOKKoR+t7Hy8Mu/cUxn2+K3jXLG71bR9Tw1KtUR17Dw5tGQ2EPyDOzd8wIZg
 OX1+mYhxEnyjQQygDF0E1sJ6QBnwDzEmW+6tyRsGZJs8QOWONhYu4Zx7lWG9vbjTnrC/I2kUP
 BxRzzToVf1Cr020k1tM0pNksk+OSGXiw8ZOwOlLvc8+NnmtgnNfy6f1vL0wTNlWOL6OJUSm1x
 2ygfX90XO93ipfch47KgNKb5IqCS4ReMeC2iJlv1mmKOPCTHnxVzlJtMEpt7jJTNyPIQ67RyI
 eWuxdmoZQzxL0o7bBC2rkNndwJcBJk7kai/CQA9VUW8q/vXmunb0eXjE0L3eeDh3aprQwsuce
 Wrz1u366cORLVn56S5LFf5IwezmryPT43rCggEjAmjvUoP3F4rP5HKsAbp+9+V5cYF2N6oeZN
 9vQeWk+516a3Qr8VNIu2fY0ATa0RaJjC1r8kXN+LcjhqG9StzBMn/+YR9uXqM1o5EiD6N8JKx
 wnQvwnTlB8bezfU9rhXbINmM7UUIdmtFKgiqzEBrzwJs0PAVu7IhOJ1782dc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the code snippet more readable.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/driver-api/pti_intel_mid.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pti_intel_mid.rst b/Documentation/dr=
iver-api/pti_intel_mid.rst
index 20f1cff42d5f..bacc2a4ee89f 100644
=2D-- a/Documentation/driver-api/pti_intel_mid.rst
+++ b/Documentation/driver-api/pti_intel_mid.rst
@@ -49,7 +49,9 @@ but is not just blindly executing as 'root'. Keep in min=
d
 the use of ioctl(,TIOCSETD,) is not specific to the n_tracerouter
 and n_tracesink line discpline drivers but is a generic
 operation for a program to use a line discpline driver
-on a tty port other than the default n_tty::
+on a tty port other than the default n_tty:
+
+.. code-block:: c

   /////////// To hook up n_tracerouter and n_tracesink /////////

=2D-
2.20.1

