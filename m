Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D0FC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E79227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTDGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:06:06 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35303 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbfLTDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:06:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TlOTnMv_1576811092;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlOTnMv_1576811092)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Dec 2019 11:04:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>, lizefan@huawei.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] docs/zh_CN: translate kernel driver statement into Chinese
Date:   Fri, 20 Dec 2019 11:04:44 +0800
Message-Id: <1576811085-30544-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576811085-30544-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576811085-30544-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel driver statement is a great statement in kernel community. This
patch translate the statement into Chinese and add it into toctree.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: lizefan@huawei.com
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/process/index.rst |   1 +
 .../zh_CN/process/kernel-driver-statement.rst      | 199 +++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/kernel-driver-statement.rst

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index f7a84eff6e93..47a2af54fb13 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -31,6 +31,7 @@
    development-process
    email-clients
    license-rules
+   kernel-driver-statement
 
 其它大多数开发人员感兴趣的社区指南：
 
diff --git a/Documentation/translations/zh_CN/process/kernel-driver-statement.rst b/Documentation/translations/zh_CN/process/kernel-driver-statement.rst
new file mode 100644
index 000000000000..2b3375bcccfd
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/kernel-driver-statement.rst
@@ -0,0 +1,199 @@
+.. _cn_process_statement_driver:
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
+内核驱动声明
+------------
+
+关于Linux内核模块的立场声明
+===========================
+
+我们，以下署名的Linux内核开发人员，认为任何封闭源Linux内核模块或驱动程序都是
+有害的和不可取的。我们已经一再发现它们对Linux用户，企业和更大的Linux生态系统
+有害。这样的模块否定了Linux开发模型的开放性，稳定性，灵活性和可维护性，并使
+他们的用户无法使用Linux社区的专业知识。提供闭源内核模块的供应商迫使其客户
+放弃Linux的主要优势或选择新的供应商。因此，为了充分利用开源所提供的成本节省和
+共享支持优势，我们敦促供应商采取措施，以开源内核代码在Linux上为其客户提供支持。
+
+我们只为自己说话，而不是我们今天可能会为之工作，过去或将来会为之工作的任何公司。
+
+ - Dave Airlie
+ - Nick Andrew
+ - Jens Axboe
+ - Ralf Baechle
+ - Felipe Balbi
+ - Ohad Ben-Cohen
+ - Muli Ben-Yehuda
+ - Jiri Benc
+ - Arnd Bergmann
+ - Thomas Bogendoerfer
+ - Vitaly Bordug
+ - James Bottomley
+ - Josh Boyer
+ - Neil Brown
+ - Mark Brown
+ - David Brownell
+ - Michael Buesch
+ - Franck Bui-Huu
+ - Adrian Bunk
+ - François Cami
+ - Ralph Campbell
+ - Luiz Fernando N. Capitulino
+ - Mauro Carvalho Chehab
+ - Denis Cheng
+ - Jonathan Corbet
+ - Glauber Costa
+ - Alan Cox
+ - Magnus Damm
+ - Ahmed S. Darwish
+ - Robert P. J. Day
+ - Hans de Goede
+ - Arnaldo Carvalho de Melo
+ - Helge Deller
+ - Jean Delvare
+ - Mathieu Desnoyers
+ - Sven-Thorsten Dietrich
+ - Alexey Dobriyan
+ - Daniel Drake
+ - Alex Dubov
+ - Randy Dunlap
+ - Michael Ellerman
+ - Pekka Enberg
+ - Jan Engelhardt
+ - Mark Fasheh
+ - J. Bruce Fields
+ - Larry Finger
+ - Jeremy Fitzhardinge
+ - Mike Frysinger
+ - Kumar Gala
+ - Robin Getz
+ - Liam Girdwood
+ - Jan-Benedict Glaw
+ - Thomas Gleixner
+ - Brice Goglin
+ - Cyrill Gorcunov
+ - Andy Gospodarek
+ - Thomas Graf
+ - Krzysztof Halasa
+ - Harvey Harrison
+ - Stephen Hemminger
+ - Michael Hennerich
+ - Tejun Heo
+ - Benjamin Herrenschmidt
+ - Kristian Høgsberg
+ - Henrique de Moraes Holschuh
+ - Marcel Holtmann
+ - Mike Isely
+ - Takashi Iwai
+ - Olof Johansson
+ - Dave Jones
+ - Jesper Juhl
+ - Matthias Kaehlcke
+ - Kenji Kaneshige
+ - Jan Kara
+ - Jeremy Kerr
+ - Russell King
+ - Olaf Kirch
+ - Roel Kluin
+ - Hans-Jürgen Koch
+ - Auke Kok
+ - Peter Korsgaard
+ - Jiri Kosina
+ - Aaro Koskinen
+ - Mariusz Kozlowski
+ - Greg Kroah-Hartman
+ - Michael Krufky
+ - Aneesh Kumar
+ - Clemens Ladisch
+ - Christoph Lameter
+ - Gunnar Larisch
+ - Anders Larsen
+ - Grant Likely
+ - John W. Linville
+ - Yinghai Lu
+ - Tony Luck
+ - Pavel Machek
+ - Matt Mackall
+ - Paul Mackerras
+ - Roland McGrath
+ - Patrick McHardy
+ - Kyle McMartin
+ - Paul Menage
+ - Thierry Merle
+ - Eric Miao
+ - Akinobu Mita
+ - Ingo Molnar
+ - James Morris
+ - Andrew Morton
+ - Paul Mundt
+ - Oleg Nesterov
+ - Luca Olivetti
+ - S.Çağlar Onur
+ - Pierre Ossman
+ - Keith Owens
+ - Venkatesh Pallipadi
+ - Nick Piggin
+ - Nicolas Pitre
+ - Evgeniy Polyakov
+ - Richard Purdie
+ - Mike Rapoport
+ - Sam Ravnborg
+ - Gerrit Renker
+ - Stefan Richter
+ - David Rientjes
+ - Luis R. Rodriguez
+ - Stefan Roese
+ - Francois Romieu
+ - Rami Rosen
+ - Stephen Rothwell
+ - Maciej W. Rozycki
+ - Mark Salyzyn
+ - Yoshinori Sato
+ - Deepak Saxena
+ - Holger Schurig
+ - Amit Shah
+ - Yoshihiro Shimoda
+ - Sergei Shtylyov
+ - Kay Sievers
+ - Sebastian Siewior
+ - Rik Snel
+ - Jes Sorensen
+ - Alexey Starikovskiy
+ - Alan Stern
+ - Timur Tabi
+ - Hirokazu Takata
+ - Eliezer Tamir
+ - Eugene Teo
+ - Doug Thompson
+ - FUJITA Tomonori
+ - Dmitry Torokhov
+ - Marcelo Tosatti
+ - Steven Toth
+ - Theodore Tso
+ - Matthias Urlichs
+ - Geert Uytterhoeven
+ - Arjan van de Ven
+ - Ivo van Doorn
+ - Rik van Riel
+ - Wim Van Sebroeck
+ - Hans Verkuil
+ - Horst H. von Brand
+ - Dmitri Vorobiev
+ - Anton Vorontsov
+ - Daniel Walker
+ - Johannes Weiner
+ - Harald Welte
+ - Matthew Wilcox
+ - Dan J. Williams
+ - Darrick J. Wong
+ - David Woodhouse
+ - Chris Wright
+ - Bryan Wu
+ - Rafael J. Wysocki
+ - Herbert Xu
+ - Vlad Yasevich
+ - Peter Zijlstra
+ - Bartlomiej Zolnierkiewicz
-- 
1.8.3.1

