Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F53B20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfD0Mz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfD0MxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:11 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mspy4-1gVqbE43aa-00tCHb; Sat, 27 Apr 2019 14:52:37 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 04/41] drivers: tty: serial: dz: fix use fix bare 'unsigned'
Date:   Sat, 27 Apr 2019 14:51:45 +0200
Message-Id: <1556369542-13247-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:CBJBinnswYpZ8Sdk7wFOAsULywVOOhB0O51QI1ZS6aG2XtvP5Ax
 rUdddfq4rw+u/9EFqOQzXc3/JM5V7fsK23L/z85bPCOANxd2GuzAoLWyurSK9Ii+GNlroRp
 D+hqD+3RuR/9qgEHat/Ucs2oZfFOYySxVG+wr6Q+wrWn6MY4YELLqYiMi6+Z1GHMHZ9Sbi6
 A0dnBU9i+mqDN3d/fmLxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MH/lZafoCx0=:C6VQMV1HsKH9OxnmfiwWwi
 ls6ASJ0mneciKIXS+1V+wSxBJcpan2IpZ08XLTD6SYv7YXOIMII1L/KWbG0T9oFUOLphs/Fg3
 l2AlwPRiDgZqonUsBVKpGTsKSv27ETHk1u8CP6XiFhZ9cNW2T3FLm/M/RZiJJEVU+b4hat+oG
 V/t5hoDjxIiN6XeMIGY3ZKep3tzRsiG+Yf5WrxF7xmHK3ns0GM3BNTiW1nXz2EqwNDtGAyeZq
 Vvqo3PBXcwPXiB6IUXXnKOdfKgojhgqctY7SufpZAYrm+1D2LBSe3PgUHcGQeS6y3DDBI1EER
 ik2lMkxjtSrUzyrZhTKgo1kjcSBthFwMG5B29FUWZC9SlsTzEYflKLY1mlrZ/DBKrktMH6+KG
 e3fXGk80CchhUtjMmL7Eyykp3o924p2zhQIBYAL0puuxE6/cYR/3HyeTlGe42KZuMH9EZn0+g
 n/3ogS9RFBh7aesoWqrAsTgXRq6ILeiUjg/9gPYWefwJguOeS1NTOW2WOOrphR2Dfrcvy72gC
 mu2hsdgjoNnA4njyhs3XxuFnlYyWLsuBOT3jqHXTTXDPK9vFMOFSfp50AeuB6lwEo12Rxs0Ip
 8eo0NdOrxwE+PMaT+iD6IJzKHMvoTFwflMb6JOcc69Pg8tOMFpOm2QWk0WlCbVyrrlaOAVFD2
 JxVH/iny2tox/lLVNnjx1smE1j9T7d7BKieB2e6XjF/H3MzZFm2Qw/hD3pnmYq+Kcy8sdTENK
 uVS7NH13R3Km3ewXsX6v4Ea4yuju79Q+cCDxjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #103: FILE: dz.c:103:
    +static u16 dz_in(struct dz_port *dport, unsigned offset)

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #110: FILE: dz.c:110:
    +static void dz_out(struct dz_port *dport, unsigned offset, u16 value)

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index b3e9313..559d076 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -100,14 +100,14 @@ static inline struct dz_port *to_dport(struct uart_port *uport)
  * ------------------------------------------------------------
  */
 
-static u16 dz_in(struct dz_port *dport, unsigned offset)
+static u16 dz_in(struct dz_port *dport, unsigned int offset)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
 	return readw(addr);
 }
 
-static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
+static void dz_out(struct dz_port *dport, unsigned int offset, u16 value)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
-- 
1.9.1

