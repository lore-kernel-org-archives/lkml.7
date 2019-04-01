Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4437320856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDAOBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:01:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:49826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfDAOBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:01:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 07:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="gz'50?scan'50,208,50";a="287708081"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2019 07:01:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hAxV8-0005ZT-6W; Mon, 01 Apr 2019 22:01:26 +0800
Date:   Mon, 1 Apr 2019 22:01:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
Message-ID: <201904012147.YfjKOfBl%lkp@intel.com>
References: <20190330141637.22632-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20190330141637.22632-1-boris.brezillon@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.1-rc3 next-20190401]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/eeprom-at25-Convert-the-driver-to-the-spi-mem-interface/20190401-160450
config: x86_64-randconfig-m3-201913 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/misc/eeprom/at25.o: In function `at25_rdsr':
>> drivers/misc/eeprom/at25.c:130: undefined reference to `spi_mem_exec_op'
   drivers/misc/eeprom/at25.o: In function `at25_ee_read':
>> drivers/misc/eeprom/at25.c:178: undefined reference to `spi_mem_dirmap_read'
   drivers/misc/eeprom/at25.o: In function `at25_create_dirmaps':
>> drivers/misc/eeprom/at25.c:86: undefined reference to `devm_spi_mem_dirmap_create'
   drivers/misc/eeprom/at25.c:94: undefined reference to `devm_spi_mem_dirmap_create'
   drivers/misc/eeprom/at25.c:106: undefined reference to `devm_spi_mem_dirmap_create'
   drivers/misc/eeprom/at25.c:114: undefined reference to `devm_spi_mem_dirmap_create'
   drivers/misc/eeprom/at25.o: In function `at25_wren':
   drivers/misc/eeprom/at25.c:144: undefined reference to `spi_mem_exec_op'
   drivers/misc/eeprom/at25.o: In function `at25_ee_write':
>> drivers/misc/eeprom/at25.c:240: undefined reference to `spi_mem_dirmap_write'
   drivers/misc/eeprom/at25.o: In function `at25_driver_init':
>> drivers/misc/eeprom/at25.c:468: undefined reference to `spi_mem_driver_register_with_owner'
   drivers/misc/eeprom/at25.o: In function `at25_driver_exit':
>> drivers/misc/eeprom/at25.c:468: undefined reference to `spi_mem_driver_unregister'

vim +130 drivers/misc/eeprom/at25.c

    70	
    71	static int at25_create_dirmaps(struct at25_data *at25)
    72	{
    73		struct spi_mem_dirmap_info info = {
    74			.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_READ, 1),
    75					      SPI_MEM_OP_ADDR(at25->addrlen, 0, 1),
    76					      SPI_MEM_OP_NO_DUMMY,
    77					      SPI_MEM_OP_DATA_IN(0, NULL, 1)),
    78			.offset = 0,
    79			.length = at25->chip.byte_len,
    80		};
    81		struct device *dev = &at25->spimem->spi->dev;
    82	
    83		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
    84			info.length = 256;
    85	
  > 86		at25->dirmap.rdesc[0] = devm_spi_mem_dirmap_create(dev, at25->spimem,
    87								   &info);
    88		if (IS_ERR(at25->dirmap.rdesc[0]))
    89			return PTR_ERR(at25->dirmap.rdesc[0]);
    90	
    91		info.op_tmpl.cmd.opcode = AT25_WRITE;
    92		info.op_tmpl.data.dir = SPI_MEM_DATA_OUT;
    93	
    94		at25->dirmap.wdesc[0] = devm_spi_mem_dirmap_create(dev, at25->spimem,
    95								   &info);
    96		if (IS_ERR(at25->dirmap.wdesc[0]))
    97			return PTR_ERR(at25->dirmap.wdesc[0]);
    98	
    99		if (!(at25->chip.flags & EE_INSTR_BIT3_IS_ADDR))
   100			return 0;
   101	
   102		info.length = at25->chip.byte_len - 256;
   103		info.op_tmpl.cmd.opcode = AT25_READ | AT25_INSTR_BIT3;
   104		info.op_tmpl.data.dir = SPI_MEM_DATA_IN;
   105	
 > 106		at25->dirmap.rdesc[1] = devm_spi_mem_dirmap_create(dev, at25->spimem,
   107								   &info);
   108		if (IS_ERR(at25->dirmap.rdesc[1]))
   109			return PTR_ERR(at25->dirmap.rdesc[1]);
   110	
   111		info.op_tmpl.cmd.opcode = AT25_WRITE | AT25_INSTR_BIT3;
   112		info.op_tmpl.data.dir = SPI_MEM_DATA_OUT;
   113	
   114		at25->dirmap.wdesc[1] = devm_spi_mem_dirmap_create(dev, at25->spimem,
   115								   &info);
   116		if (IS_ERR(at25->dirmap.wdesc[1]))
   117			return PTR_ERR(at25->dirmap.wdesc[1]);
   118	
   119		return 0;
   120	}
   121	
   122	static int at25_rdsr(struct at25_data *at25)
   123	{
   124		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_RDSR, 1),
   125						  SPI_MEM_OP_NO_ADDR,
   126						  SPI_MEM_OP_NO_DUMMY,
   127						  SPI_MEM_OP_DATA_IN(1, at25->scratchbuf, 1));
   128		int ret;
   129	
 > 130		ret = spi_mem_exec_op(at25->spimem, &op);
   131		if (ret)
   132			return ret;
   133	
   134		return *((u8 *)at25->scratchbuf);
   135	}
   136	
   137	static int at25_wren(struct at25_data *at25)
   138	{
   139		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_WREN, 1),
   140						  SPI_MEM_OP_NO_ADDR,
   141						  SPI_MEM_OP_NO_DUMMY,
   142						  SPI_MEM_OP_NO_DATA);
   143	
   144		return spi_mem_exec_op(at25->spimem, &op);
   145	}
   146	
   147	static int at25_ee_read(void *priv, unsigned int offset,
   148				void *val, size_t count)
   149	{
   150		struct spi_mem_dirmap_desc *desc;
   151		struct at25_data *at25 = priv;
   152		unsigned int dirmap_offset;
   153		ssize_t			status;
   154	
   155		if (unlikely(offset >= at25->chip.byte_len))
   156			return -EINVAL;
   157		if ((offset + count) > at25->chip.byte_len)
   158			count = at25->chip.byte_len - offset;
   159		if (unlikely(!count))
   160			return -EINVAL;
   161	
   162		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && offset > 255) {
   163			desc = at25->dirmap.rdesc[1];
   164			dirmap_offset = offset - 256;
   165		} else {
   166			desc = at25->dirmap.rdesc[0];
   167			dirmap_offset = offset;
   168		}
   169	
   170		mutex_lock(&at25->lock);
   171	
   172		/* Read it all at once.
   173		 *
   174		 * REVISIT that's potentially a problem with large chips, if
   175		 * other devices on the bus need to be accessed regularly or
   176		 * this chip is clocked very slowly
   177		 */
 > 178		status = spi_mem_dirmap_read(desc, dirmap_offset, count, val);
   179		dev_dbg(&at25->spimem->spi->dev, "read %zu bytes at %d --> %zd\n",
   180			count, offset, status);
   181	
   182		mutex_unlock(&at25->lock);
   183		return status;
   184	}
   185	
   186	static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
   187	{
   188		struct at25_data *at25 = priv;
   189		const char *buf = val;
   190		int			status = 0;
   191		unsigned		buf_size;
   192		u8			*bounce;
   193	
   194		if (unlikely(off >= at25->chip.byte_len))
   195			return -EFBIG;
   196		if ((off + count) > at25->chip.byte_len)
   197			count = at25->chip.byte_len - off;
   198		if (unlikely(!count))
   199			return -EINVAL;
   200	
   201		/* Temp buffer starts with command and address */
   202		buf_size = at25->chip.page_size;
   203		if (buf_size > io_limit)
   204			buf_size = io_limit;
   205		bounce = kmalloc(buf_size, GFP_KERNEL);
   206		if (!bounce)
   207			return -ENOMEM;
   208	
   209		/* For write, rollover is within the page ... so we write at
   210		 * most one page, then manually roll over to the next page.
   211		 */
   212		mutex_lock(&at25->lock);
   213		do {
   214			struct spi_mem_dirmap_desc *desc;
   215			unsigned long	timeout, retries;
   216			unsigned	segment;
   217			unsigned int	dirmap_offset;
   218			int		sr;
   219	
   220			status = at25_wren(at25);
   221			if (status < 0) {
   222				dev_dbg(&at25->spimem->spi->dev, "WREN --> %d\n",
   223					status);
   224				break;
   225			}
   226	
   227			if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && off > 255) {
   228				desc = at25->dirmap.wdesc[1];
   229				dirmap_offset = off -  256;
   230			} else {
   231				desc = at25->dirmap.wdesc[0];
   232				dirmap_offset = off;
   233			}
   234	
   235			/* Write as much of a page as we can */
   236			segment = buf_size - (dirmap_offset % buf_size);
   237			if (segment > count)
   238				segment = count;
   239			memcpy(bounce, buf, segment);
 > 240			status = spi_mem_dirmap_write(desc, dirmap_offset, segment,
   241						      bounce);
   242			dev_dbg(&at25->spimem->spi->dev,
   243				"write %u bytes at %u --> %d\n",
   244				segment, off, status);
   245			if (status < 0)
   246				break;
   247	
   248			/* REVISIT this should detect (or prevent) failed writes
   249			 * to readonly sections of the EEPROM...
   250			 */
   251	
   252			/* Wait for non-busy status */
   253			timeout = jiffies + msecs_to_jiffies(EE_TIMEOUT);
   254			retries = 0;
   255			do {
   256				sr = at25_rdsr(at25);
   257				if (sr < 0 || (sr & AT25_SR_nRDY)) {
   258					dev_dbg(&at25->spimem->spi->dev,
   259						"rdsr --> %d (%02x)\n", sr, sr);
   260					/* at HZ=100, this is sloooow */
   261					msleep(1);
   262					continue;
   263				}
   264				if (!(sr & AT25_SR_nRDY))
   265					break;
   266			} while (retries++ < 3 || time_before_eq(jiffies, timeout));
   267	
   268			if ((sr < 0) || (sr & AT25_SR_nRDY)) {
   269				dev_err(&at25->spimem->spi->dev,
   270					"write %u bytes offset %u, timeout after %u msecs\n",
   271					segment, off,
   272					jiffies_to_msecs(jiffies -
   273						(timeout - EE_TIMEOUT)));
   274				status = -ETIMEDOUT;
   275				break;
   276			}
   277	
   278			off += segment;
   279			buf += segment;
   280			count -= segment;
   281	
   282		} while (count > 0);
   283	
   284		mutex_unlock(&at25->lock);
   285	
   286		kfree(bounce);
   287		return status;
   288	}
   289	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
