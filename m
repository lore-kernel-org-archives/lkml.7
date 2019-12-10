Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D43120838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988653;
	bh=EB9ChD0hXmG5xdPjCrhg5MAtFSmavgKATxmIiH5oyrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6YD/4wjK5IjqSBCVRAmgAO8RUKy03HSKSDt/FIZx2xTiU7xqH/1ivqE1p94lzlXU
	 vkkSRmZRHNu+JVmlfJy58DjnbkCfZb31sH8zI6Olx8xIE8iZZfuGkbMfzV5I2QMy6w
	 +HMuEsViJKmttJkbvnQb8TtxxUfj0E8VzDzSz+Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLJOhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbfLJOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159E420663;
        Tue, 10 Dec 2019 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988647;
        bh=EB9ChD0hXmG5xdPjCrhg5MAtFSmavgKATxmIiH5oyrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaZIBfVhoxrb0bPGi+HmOCcQWvZuNi7S4YBDyn1sWgzZlHs4IudRF/17WuvrlPr8Y
         jGynrj3b3XkU866mQz0DUMgxuNs5vvGfNwT/QCc/mxzBOlNSrqGVH6WZhgjdiamREL
         q35DZMIHYUi75Bp+q2RcTNye2HqHTwNvj5E/yvOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] tty: serial: samsung_tty: delete samsung.h
Date:   Tue, 10 Dec 2019 15:37:01 +0100
Message-Id: <20191210143706.3928480-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for a .h file for a single .c file, so just move all of
the content of samsung.h into samsung_tty.c

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.h     | 144 -------------------------------
 drivers/tty/serial/samsung_tty.c | 133 +++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 147 deletions(-)
 delete mode 100644 drivers/tty/serial/samsung.h

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
deleted file mode 100644
index 7255ef287857..000000000000
--- a/drivers/tty/serial/samsung.h
+++ /dev/null
@@ -1,144 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SAMSUNG_H
-#define __SAMSUNG_H
-
-/*
- * Driver for Samsung SoC onboard UARTs.
- *
- * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- */
-
-#include <linux/dmaengine.h>
-
-struct s3c24xx_uart_info {
-	char			*name;
-	unsigned int		type;
-	unsigned int		fifosize;
-	unsigned long		rx_fifomask;
-	unsigned long		rx_fifoshift;
-	unsigned long		rx_fifofull;
-	unsigned long		tx_fifomask;
-	unsigned long		tx_fifoshift;
-	unsigned long		tx_fifofull;
-	unsigned int		def_clk_sel;
-	unsigned long		num_clks;
-	unsigned long		clksel_mask;
-	unsigned long		clksel_shift;
-
-	/* uart port features */
-
-	unsigned int		has_divslot:1;
-};
-
-struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	*info;
-	struct s3c2410_uartcfg		*def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
-};
-
-struct s3c24xx_uart_dma {
-	unsigned int			rx_chan_id;
-	unsigned int			tx_chan_id;
-
-	struct dma_slave_config		rx_conf;
-	struct dma_slave_config		tx_conf;
-
-	struct dma_chan			*rx_chan;
-	struct dma_chan			*tx_chan;
-
-	dma_addr_t			rx_addr;
-	dma_addr_t			tx_addr;
-
-	dma_cookie_t			rx_cookie;
-	dma_cookie_t			tx_cookie;
-
-	char				*rx_buf;
-
-	dma_addr_t			tx_transfer_addr;
-
-	size_t				rx_size;
-	size_t				tx_size;
-
-	struct dma_async_tx_descriptor	*tx_desc;
-	struct dma_async_tx_descriptor	*rx_desc;
-
-	int				tx_bytes_requested;
-	int				rx_bytes_requested;
-};
-
-struct s3c24xx_uart_port {
-	unsigned char			rx_claimed;
-	unsigned char			tx_claimed;
-	unsigned int			pm_level;
-	unsigned long			baudclk_rate;
-	unsigned int			min_dma_size;
-
-	unsigned int			rx_irq;
-	unsigned int			tx_irq;
-
-	unsigned int			tx_in_progress;
-	unsigned int			tx_mode;
-	unsigned int			rx_mode;
-
-	struct s3c24xx_uart_info	*info;
-	struct clk			*clk;
-	struct clk			*baudclk;
-	struct uart_port		port;
-	struct s3c24xx_serial_drv_data	*drv_data;
-
-	/* reference to platform data */
-	struct s3c2410_uartcfg		*cfg;
-
-	struct s3c24xx_uart_dma		*dma;
-
-#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
-	struct notifier_block		freq_transition;
-#endif
-};
-
-/* conversion functions */
-
-#define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
-
-/* register access controls */
-
-#define portaddr(port, reg) ((port)->membase + (reg))
-#define portaddrl(port, reg) \
-	((unsigned long *)(unsigned long)((port)->membase + (reg)))
-
-#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
-#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
-
-#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
-#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
-
-/* Byte-order aware bit setting/clearing functions. */
-
-static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
-				   unsigned int reg)
-{
-	unsigned long flags;
-	u32 val;
-
-	local_irq_save(flags);
-	val = rd_regl(port, reg);
-	val |= (1 << idx);
-	wr_regl(port, reg, val);
-	local_irq_restore(flags);
-}
-
-static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
-				     unsigned int reg)
-{
-	unsigned long flags;
-	u32 val;
-
-	local_irq_save(flags);
-	val = rd_regl(port, reg);
-	val &= ~(1 << idx);
-	wr_regl(port, reg, val);
-	local_irq_restore(flags);
-}
-
-#endif
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 67c5a84d0a26..1a3bf5879344 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -44,11 +44,8 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/of.h>
-
 #include <asm/irq.h>
 
-#include "samsung.h"
-
 #if	defined(CONFIG_SERIAL_SAMSUNG_DEBUG) &&	\
 	!defined(MODULE)
 
@@ -89,6 +86,136 @@ static void dbg(const char *fmt, ...)
 /* flag to ignore all characters coming in */
 #define RXSTAT_DUMMY_READ (0x10000000)
 
+struct s3c24xx_uart_info {
+	char			*name;
+	unsigned int		type;
+	unsigned int		fifosize;
+	unsigned long		rx_fifomask;
+	unsigned long		rx_fifoshift;
+	unsigned long		rx_fifofull;
+	unsigned long		tx_fifomask;
+	unsigned long		tx_fifoshift;
+	unsigned long		tx_fifofull;
+	unsigned int		def_clk_sel;
+	unsigned long		num_clks;
+	unsigned long		clksel_mask;
+	unsigned long		clksel_shift;
+
+	/* uart port features */
+
+	unsigned int		has_divslot:1;
+};
+
+struct s3c24xx_serial_drv_data {
+	struct s3c24xx_uart_info	*info;
+	struct s3c2410_uartcfg		*def_cfg;
+	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+};
+
+struct s3c24xx_uart_dma {
+	unsigned int			rx_chan_id;
+	unsigned int			tx_chan_id;
+
+	struct dma_slave_config		rx_conf;
+	struct dma_slave_config		tx_conf;
+
+	struct dma_chan			*rx_chan;
+	struct dma_chan			*tx_chan;
+
+	dma_addr_t			rx_addr;
+	dma_addr_t			tx_addr;
+
+	dma_cookie_t			rx_cookie;
+	dma_cookie_t			tx_cookie;
+
+	char				*rx_buf;
+
+	dma_addr_t			tx_transfer_addr;
+
+	size_t				rx_size;
+	size_t				tx_size;
+
+	struct dma_async_tx_descriptor	*tx_desc;
+	struct dma_async_tx_descriptor	*rx_desc;
+
+	int				tx_bytes_requested;
+	int				rx_bytes_requested;
+};
+
+struct s3c24xx_uart_port {
+	unsigned char			rx_claimed;
+	unsigned char			tx_claimed;
+	unsigned int			pm_level;
+	unsigned long			baudclk_rate;
+	unsigned int			min_dma_size;
+
+	unsigned int			rx_irq;
+	unsigned int			tx_irq;
+
+	unsigned int			tx_in_progress;
+	unsigned int			tx_mode;
+	unsigned int			rx_mode;
+
+	struct s3c24xx_uart_info	*info;
+	struct clk			*clk;
+	struct clk			*baudclk;
+	struct uart_port		port;
+	struct s3c24xx_serial_drv_data	*drv_data;
+
+	/* reference to platform data */
+	struct s3c2410_uartcfg		*cfg;
+
+	struct s3c24xx_uart_dma		*dma;
+
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
+	struct notifier_block		freq_transition;
+#endif
+};
+
+/* conversion functions */
+
+#define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
+
+/* register access controls */
+
+#define portaddr(port, reg) ((port)->membase + (reg))
+#define portaddrl(port, reg) \
+	((unsigned long *)(unsigned long)((port)->membase + (reg)))
+
+#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
+#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
+
+#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
+
+/* Byte-order aware bit setting/clearing functions. */
+
+static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
+				   unsigned int reg)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = rd_regl(port, reg);
+	val |= (1 << idx);
+	wr_regl(port, reg, val);
+	local_irq_restore(flags);
+}
+
+static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
+				     unsigned int reg)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = rd_regl(port, reg);
+	val &= ~(1 << idx);
+	wr_regl(port, reg, val);
+	local_irq_restore(flags);
+}
+
 static inline struct s3c24xx_uart_port *to_ourport(struct uart_port *port)
 {
 	return container_of(port, struct s3c24xx_uart_port, port);
-- 
2.24.0

