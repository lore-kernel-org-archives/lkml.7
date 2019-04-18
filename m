Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A2C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555603568;
	bh=epH0oMv9aR1kGXFWT0ji8ZKPiDjGR7C+zhkRMj5pnW8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AVDUROl3eKWzeSWXW+nqK+U6rjEn0XuVxNaxw78Rw0sfvVdNcHKWOON/afQFZgFYm
	 g5CI68YiRT+WqqXQRA/X+kxabLqMN0epUhIxAnWGwxSq2BQlCE3HVZJBS8/Iz5XNdi
	 XQkoH0XNhS68K7ByjVdC2bsn1FHDYEfcflMVVkdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbfDRQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:06:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36395 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbfDRQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:06:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so2052163lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blNEZg1O+9B1fHyZr1az8Un2VNCkdA4mdbe50MGdMfQ=;
        b=hUtJY3pbz7V3VRXqq6jf9VIr0i9Tl5fqeC9ZtTcblKpvMHymn1J0jv9pBUlggJ4/6y
         Oqhu/JH3YSpQbA72NDyqOnQMcs8jCGqrcMVyg8tlwPL0MqHgMgIWAxM2IiLbtPwmTKlA
         3QqLIyO+L6NUQIAyBiBeaQ6wKBMTZzsc9Z3J+X/VG0LYxGNn49BKZRo2WlUcVLoTBxxh
         ySPf8bk/b/aHO2rY8aIPDxUW2NdZ6cTRmf2+Lt1M+eKRec2FaMmGM5CLNtZRnCTj7/ZX
         mX3kQjERkXhPIsxhGm9mqVlQrauFg4cJmJ4fVRaplSB/MycHVGwBdzDidYzOayk3+KjF
         l93g==
X-Gm-Message-State: APjAAAVXAPeeXcUuLoPsjtdk3Tfu2ddydbkQS8Di9mK0eljqE5Ejf+0Q
        /3CSCzZgmC0dDijUQnAeFzU=
X-Google-Smtp-Source: APXvYqwyddzlui3WxIoaGKecTF2A6TrgWirsw91Ax1EHi1Bc8+5H740MaMg+vixBx0zdBkVQeVQzZg==
X-Received: by 2002:a19:6d0b:: with SMTP id i11mr23777984lfc.147.1555603564792;
        Thu, 18 Apr 2019 09:06:04 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d23sm514936lfj.64.2019.04.18.09.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:06:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hH9YE-0004fV-9t; Thu, 18 Apr 2019 18:06:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] tty: update obsolete termios comment
Date:   Thu, 18 Apr 2019 18:05:54 +0200
Message-Id: <20190418160554.17894-1-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update an obsolete comment referring to the termios_locked structure
which was removed over a decade ago by commit fe6e29fdb1a7 ("tty:
simplify ktermios allocation").

While at it, fix the "Thus" typo.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5fa250157025..033ac7e6a70d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1173,7 +1173,7 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
  *	tty_init_termios	-  helper for termios setup
  *	@tty: the tty to set up
  *
- *	Initialise the termios structures for this tty. Thus runs under
+ *	Initialise the termios structure for this tty. This runs under
  *	the tty_mutex currently so we can be relaxed about ordering.
  */
 
-- 
2.21.0

