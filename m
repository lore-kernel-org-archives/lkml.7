Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92027C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC3520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCHUTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:19:40 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:19:40 -0500
Received: from [192.168.1.110] ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSLEm-1hUuNd1ylU-00Sgex; Fri, 08 Mar 2019 21:19:29 +0100
Subject: Re: [PATCH 2/4] Add SUNIX Multi-I/O card device driver
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20190308123432.20520-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f675a0a1-8cc3-8bc9-8846-07e5e156c48e@metux.net>
Date:   Fri, 8 Mar 2019 21:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190308123432.20520-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PzLPZX7pAT7oxfU3TRcksS+6Z1dWS6YwhowbSHBvDsHH+psvfq5
 oRNnoDIZKTyJBJyyw/N/c4dHOkMoycEQLdF+b4KuXnqEgVYEMFZAT8b32YOx8IAZ49jmjDT
 n1Y/qhFTiP/dW05Z3wWmOZS2c38It7j7vSpkM/w7xB4OWfHtBFhwnwrXfkUOazmCSkRTMED
 9bC/ihHr05FgDbT+ELJlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5oFa7cZgZ98=:Qf60dP5m7vdNHfxGh2rBur
 IGOPT8+sOuuCAbtt5FMasSEVwNFPmfhiBS62eA5kWWK9cfVIQ9kUMRdqvk+WTFzXegNq/9e/j
 4dNGA24TDVrt5udea0+xthwBGqFkyjz9u+HhYPp4fHOkRtoF8hpZcBNt+A1gZdDq7tA7yHqfo
 17zhQYNHZfbRpkzbtujFott9gT88e4y1sOAsiG5o56SsmQmtIdGadrPwl9sNdNaGAOcDd5g8+
 iZtJ87PQ3d12Gxna/ZuoOIm05JDfmUa78xYOw3THBTpnqo2I/S5Db68JnsHUDq/yiYuGppHsd
 IubvZ3r+/VJzvmkH+CB9x21rXvocEcvppDL/xNOLG6kQEUI5LsT22+1DMIhAcsFx9yKbOG6qx
 K3hLAxcAzkwqvVL5Zf5CRMupVXliHAjc1tD3YXIp69OR9cfc6zKUGb3dLpAmlGcJ0F4BcAbUv
 EyXP7Zu+cq1qSIk/xxYlKbfa8lUfWicqQwQQNxlnvUnTiMjPJy8I9fMa7un74kPFWhwzjGe/3
 H3XryGuXlSDSd6Jsinrhis1fYBfojExIhBoKyz88s1TUoKjCJqdiyRFCNrbX6fkCT0VcGpRSu
 uMXo41s2T88lWSYHc/qzh0qqMChpk310GNWT8Pt63adekmPHJS8byDcFHfJWYuJodPBasYSMk
 Af6sT5juf6l4UFQga59jAq0Di/VQEfx3khQsd17+AMma9o/In5H5uLLOpPV/R3PCJh9KP+7c7
 qFkCixXs0eDMZ97xoqxSvqdvVfBp5HTSEHOdyEh0FUw1fkQzChVdu/lTHFY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.19 13:34, Morris Ku wrote:

Hi,

<snip>

> diff --git a/char/snx/snx_main.c b/char/snx/snx_main.c

if it's a serial card, shouldn't it go to drivers/tty/serial/snx/ ?

<snip>

> +char snx_ser_ic_table[SNX_SER_PORT_MAX_UART][10] = {
> +	{"UNKNOWN"},
> +	{"SUN1889"},
> +	{"SUN1699"},
> +	{"SUNMATX"},
> +	{"SUN1999"}
> +};
> +
> +char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10] = {
> +	{"UNKNOWN"},
> +	{"SUN1888"},
> +	{"SUN1689"},
> +	{"SUNMATX"},
> +	{"SUN1999"}
> +};
> +
> +char snx_port_remap[2][10] = {
> +	{"NON-REMAP"},
> +	{"REMAP"}
> +};

can't these be const static ?

> +
> +enum{
> +// golden-serial
> +	GOLDEN_BOARD_TEST = 0,
> +
> +// matrix-serial
> +	MATRIX_BOARD_P1002,
> +	MATRIX_BOARD_P1004,
> +	MATRIX_BOARD_P1008,
> +	MATRIX_BOARD_P1016,
> +	MATRIX_BOARD_P2002,
> +	MATRIX_BOARD_P2004,
> +	MATRIX_BOARD_P2008,
> +	MATRIX_BOARD_P3002,
> +	MATRIX_BOARD_P3004,
> +	MATRIX_BOARD_P3008,
> +
> +// sun1999-serial RS232
> +	SUN1999_BOARD_5027A,
> +	SUN1999_BOARD_5037A,
> +	SUN1999_BOARD_5056A,
> +	SUN1999_BOARD_5066A,
> +	SUN1999_BOARD_5016A,
> +
> +	//sun1999-multi I/O
> +	SUN1999_BOARD_5069A,
> +	SUN1999_BOARD_5079A,
> +	SUN1999_BOARD_5099A,
> +
> +	//sun1999-parallel
> +

can we have a bit more consistent formatting (eg. all those comments
w/ same indention) ?

> +	SUN1999_BOARD_5008A,
> +

<snip>

> +static  struct pci_device_id	sunix_pci_board_id[] = {
> +// golden-serial

can't this be const ?
(maybe even __initconst)

> +	{VENID_GOLDEN,	DEVID_G_SERIAL,	SUBVENID_GOLDEN,
> +		SUBDEVID_TEST,	0,	0,	GOLDEN_BOARD_TEST},
> +
> +// matrix-serial
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P1002,	0,	0,	MATRIX_BOARD_P1002},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P1004,	0,	0,	MATRIX_BOARD_P1004},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P1008,	0,	0,	MATRIX_BOARD_P1008},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P1016,	0,	0,	MATRIX_BOARD_P1016},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P2002,	0,	0,	MATRIX_BOARD_P2002},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P2004,	0,	0,	MATRIX_BOARD_P2004},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P2008,	0,	0,	MATRIX_BOARD_P2008},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P3002,	0,	0,	MATRIX_BOARD_P3002},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P3004,	0,	0,	MATRIX_BOARD_P3004},
> +	{VENID_MATRIX,	DEVID_M_SERIAL,	SUBVENID_MATRIX,
> +		SUBDEVID_P3008,	0,	0,	MATRIX_BOARD_P3008},
> +
> +	// sun1999-serial RS232
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5027A,	0,	0,	SUN1999_BOARD_5027A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5037A,	0,	0,	SUN1999_BOARD_5037A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5056A,	0,	0,	SUN1999_BOARD_5056A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5066A,	0,	0,	SUN1999_BOARD_5066A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5016A,	0,	0,	SUN1999_BOARD_5016A},
> +
> +	// sun1999-multi I/O
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5069A,	0,	0,	SUN1999_BOARD_5069A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5079A,	0,	0,	SUN1999_BOARD_5079A},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_5099A,	0,	0,	SUN1999_BOARD_5099A},
> +
> +	// sun1999-parallel
> +	{VENID_SUN1999,	DEVID_S_PARALL,	SUBVENID_SUN1999,
> +		SUBDEVID_5008A,	0,	0,	SUN1999_BOARD_5008A},
> +
> +	// sun1999-serial RS422/485
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P2102,	0,	0,	SUN1999_BOARD_P2102},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P2104,	0,	0,	SUN1999_BOARD_P2104},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P2108,	0,	0,	SUN1999_BOARD_P2108},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P2116,	0,	0,	SUN1999_BOARD_P2116},
> +
> +	// sun1999 3_in_1
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P3104,	0,	0,	SUN1999_BOARD_P3104},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_P3108,	0,	0,	SUN1999_BOARD_P3108},
> +
> +	//cash drawer card  2S
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_CASH_2S, 0,	0,	SUN1999_BOARD_CASH_2S},
> +
> +	//cash drawer card  4S
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_CASH_4S, 0,	0,	SUN1999_BOARD_CASH_4S},
> +
> +	//DIO
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_DIO0802, 0,	0,	SUN1999_BOARD_DIO0802},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_DIO1604, 0,	0,	SUN1999_BOARD_DIO1604},
> +	{VENID_SUN1999,	DEVID_S_SERIAL,	SUBVENID_SUN1999,
> +		SUBDEVID_DIO3204, 0,	0,	SUN1999_BOARD_DIO3204},
> +
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, sunix_pci_board_id);
> +
> +struct sunix_board			sunix_board_table[SNX_BOARDS_MAX];
> +struct sunix_ser_port	    sunix_ser_table[SNX_SER_TOTAL_MAX + 1];
> +struct sunix_par_port	    sunix_par_table[SNX_PAR_TOTAL_MAX];

I'd really prefer separate port types - that go into separate
subsystems, in separate modules (those can share code in a common
module, if desired)

Oh, is there really a hard restriction on the max number of boards ?

And do we really need a global list of them ? (instead of just having
all per-board / per-port data in a per-board / per-port driver instance)

> +static int snx_ser_port_total_cnt;
> +static int snx_par_port_total_cnt;
> +
> +int snx_board_count;
> +
> +static struct snx_ser_driver	sunix_ser_reg = {
> +	.dev_name = "ttySNX",
> +	.major = 0,
> +	.minor = 0,
> +	.nr = (SNX_SER_TOTAL_MAX + 1),
> +};

can't this be const ?

> +static irqreturn_t sunix_interrupt(int irq, void *dev_id)
> +{
> +	struct sunix_ser_port *sp = NULL;
> +	struct sunix_par_port *pp = NULL;
> +	struct sunix_board *sb = NULL;
> +	int i;
> +	int status = 0;
> +
> +	int handled = IRQ_NONE;
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +
> +		if (dev_id == &(sunix_board_table[i])) {
> +			sb = dev_id;
> +			break;
> +		}
> +	}

maybe put this index into the board data, so the loop on the global
array isn't needed ?

<snip>

> +	if ((sb->ser_port > 0) && (sb->ser_isr != NULL)) {
> +		sp = &sunix_ser_table[sb->ser_port_index];

maybe put this pointer struct sunix_board so the lookup in the
global array isn't necessary ?

<snip>

> +	if ((sb->par_port > 0) && (sb->par_isr != NULL)) {
> +		pp = &sunix_par_table[sb->par_port_index];
> +
> +		if (!pp)
> +			status = 1;
> +
> +		status = sb->par_isr(sb, pp);
> +	}
> +
> +	if (status != 0)
> +		return handled;
> +
> +	handled = IRQ_HANDLED;
> +	return handled;
> +}

btw: is there only one irq per board or one per port ?


> +static int snx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	return 0;

shouldn't probe check whether the device is actually there and then do
the initialization ?

<snip>

> +static int snx_resume_port_termios(struct snx_ser_info *info)
> +{
> +	struct snx_ser_state *state = NULL;
> +	struct tty_struct *tty = info->tty;
> +
> +	state = tty->driver_data;
> +	snx_set_port_termios(state);
> +
> +	return 0;
> +}
> +
> +

do we need multiple newlines here ?

<snip>

> +static int snx_resume_one(struct pci_dev *pdev)
> +{
> +	struct sunix_board *sb = pci_get_drvdata(pdev);
> +	struct sunix_ser_port *sp = NULL;
> +	int j;
> +
> +	if (sb == NULL)
> +		return 0;
> +
> +	for (j = 0; j < sb->ser_port; j++) {
> +		sp = &sunix_ser_table[j];

can't the pointers to the serial ports be in struct sunix_board instead
of an global array ?

> +static int sunix_pci_board_probe(void)
> +{
> +	struct sunix_board *sb;
> +	struct pci_dev *pdev = NULL;
> +	struct pci_dev *pdev_array[4] = {NULL, NULL, NULL, NULL};
> +
> +	int sunix_pci_board_id_cnt;
> +	int tablecnt;
> +	int boardcnt;
> +	int i;
> +	unsigned short int sub_device_id;
> +	unsigned short int device_part_number;
> +	unsigned int bar3_base_add;
> +
> +	int status;
> +	unsigned int bar3_Byte5;
> +	unsigned int bar3_Byte6;
> +	unsigned int bar3_Byte7;
> +	unsigned int oem_id;
> +	unsigned char uart_type;
> +	unsigned char gpio_type;
> +	unsigned char gpio_card_type;
> +	int gpio_ch_cnt;
> +
> +	// clear and init some variable
> +	memset(sunix_board_table, 0, SNX_BOARDS_MAX *
> +	sizeof(struct sunix_board));
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +		sunix_board_table[i].board_enum = -1;
> +		sunix_board_table[i].board_number = -1;

if it already is a global, why not statically initialized ?

> +	}
> +
> +	sunix_pci_board_id_cnt =
> +	(sizeof(sunix_pci_board_id) / sizeof(sunix_pci_board_id[0])) - 1;
> +
> +	// search matrix serial board
> +	pdev = NULL;
> +	tablecnt = 0;
> +	boardcnt = 0;
> +	sub_device_id = 0;
> +	status = 0;
> +
> +	while (tablecnt < sunix_pci_board_id_cnt) {
> +
> +		pdev = pci_get_device(VENID_MATRIX, DEVID_M_SERIAL, pdev);
> +
> +		if (pdev == NULL) {
> +			tablecnt++;
> +			continue;
> +		}
> +
> +		if ((tablecnt > 0) && ((pdev == pdev_array[0]) ||
> +		(pdev == pdev_array[1]) ||
> +		(pdev == pdev_array[2]) ||
> +		(pdev == pdev_array[3]))) {
> +			continue;
> +		}
> +
> +		pci_read_config_word(pdev, 0x2e, &sub_device_id);
> +
> +		if (sub_device_id == 0) {
> +			status = -EIO;
> +			return status;
> +		}
> +
> +		if (sub_device_id != sunix_pci_board_id[tablecnt].subdevice)
> +			continue;
> +		if (pdev == NULL) {
> +			pr_err("SNX Error: PCI device object is NULL !\n");
> +			status = -EIO;
> +			return status;
> +
> +		} else {
> +
> +			status = pci_enable_device(pdev);
> +
> +			if (status != 0) {
> +				pr_err("SNX Error: SUNIX Board Enable Fail !\n\n");
> +				status = -ENXIO;
> +				return status;
> +			}
> +		}
> +
> +		boardcnt++;
> +		if (boardcnt > SNX_BOARDS_MAX) {
> +			pr_err("SNX Error: Support Four Boards In Maximum !\n");
> +			status = -ENOSPC;
> +			return status;
> +		}
> +
> +		sb = &sunix_board_table[boardcnt-1];
> +		pdev_array[boardcnt-1] = pdev;
> +		sb->pdev = pdev;
> +		sb->bus_number = pdev->bus->number;
> +		sb->dev_number = PCI_SLOT(pdev->devfn);
> +		sb->board_enum = (int)sunix_pci_board_id[tablecnt].driver_data;
> +		sb->pb_info = snx_pci_board_conf[sb->board_enum];
> +		sb->board_flag = sb->pb_info.board_flag;
> +		sb->board_number = boardcnt - 1;
> +	}

Why not doing this in snx_pci_probe() on per-board basis, and let device
registration be done by pci subsystem ?

> +	// search sun1999 muti I/O board
> +	pdev = NULL;
> +	tablecnt = 0;
> +	sub_device_id = 0;
> +	status = 0;
> +	device_part_number = 0;
> +	bar3_base_add = 0;
> +	bar3_Byte5 = 0;
> +	bar3_Byte6 = 0;
> +	bar3_Byte7 = 0;
> +	oem_id = 0;
> +	uart_type = 0;
> +	gpio_type = 0;
> +	gpio_card_type = 0;
> +	gpio_ch_cnt = 0;

completely different boards handled by one big driver ?
why not splitting it up into multiple drivers ?

<snip>

> +		if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x01))
> +			gpio_ch_cnt = 6;
> +		else if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x02))
> +			gpio_ch_cnt = 8;
> +		else if (gpio_ch_cnt == 0x01)
> +			gpio_ch_cnt = 16;
> +		else if (gpio_ch_cnt == 0x02)
> +			gpio_ch_cnt = 32;
> +

gpio devices have their own subsystem -> therefore: write a separate
gpio driver for that.

<snip>

> +static int sunix_get_pci_board_conf(void)
> +{
> +	struct sunix_board *sb = NULL;
> +	struct pci_dev *pdev = NULL;
> +	int status = 0;
> +	int i;
> +	int j;
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +		sb = &sunix_board_table[i];
> +
> +		if (sb->board_enum > 0) {
> +			pdev = sb->pdev;
> +			sb->ports = sb->pb_info.num_serport +
> +				sb->pb_info.num_parport;
> +			sb->ser_port = sb->pb_info.num_serport;
> +			sb->par_port = sb->pb_info.num_parport;
> +			snx_ser_port_total_cnt = snx_ser_port_total_cnt +
> +				sb->ser_port;
> +			snx_par_port_total_cnt = snx_par_port_total_cnt +
> +				sb->par_port;
> +
> +			if (snx_ser_port_total_cnt > SNX_SER_TOTAL_MAX) {
> +				pr_err("SNX Error: Too much serial port\n");
> +				status = -EIO;
> +				return status;
> +			}

why that limitation ? why does this have to be a global array at all ?

> +static int sunix_assign_resource(void)
> +{
> +	struct sunix_board *sb = NULL;
> +	struct sunix_ser_port *sp = NULL;
> +	struct sunix_par_port *pp = NULL;
> +
> +	int status = 0;
> +	int i;
> +	int j;
> +	int k;
> +	int ser_n;
> +	int ser_port_index = 0;
> +
> +	memset(sunix_ser_table, 0, (SNX_SER_TOTAL_MAX + 1) *
> +	sizeof(struct sunix_ser_port));
> +
> +	memset(sunix_par_table, 0, (SNX_PAR_TOTAL_MAX) *
> +	sizeof(struct sunix_par_port));

why this w/ global variables, instead of on per-device basis on device-
private data ?

<snip>

> +static int sunix_ser_port_table_init(void)
> +{

same here.

<snip>

> +static int sunix_par_port_table_init(void)
> +{

same here

> +int sunix_register_irq(void)
> +{

same here.

<snip>

> +static int __init snx_init(void)
> +{
> +	int status = 0;
> +
> +	pr_err("SNX Info : Loading SUNIX Multi-I/O Board Driver Module\n");
> +
> +	snx_ser_port_total_cnt = snx_par_port_total_cnt = 0;
> +
> +	status = sunix_pci_board_probe();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_get_pci_board_conf();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_assign_resource();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_ser_port_table_init();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_par_port_table_init();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_register_irq();
> +	if (status != 0)
> +		goto step1_fail;
> +
> +	status = sunix_ser_register_driver(&sunix_ser_reg);
> +	if (status != 0)
> +		goto step2_fail;
> +
> +	status = sunix_ser_register_ports(&sunix_ser_reg);
> +	if (status != 0)
> +		goto step3_fail;
> +
> +	status = pci_register_driver(&snx_pci_driver);
> +	if (status != 0)
> +		goto step7_fail;
> +
> +	if (snx_par_port_total_cnt > 0) {
> +		status = sunix_par_parport_init();
> +		if (status != 0)
> +			goto step4_fail;
> +
> +		status = sunix_par_ppdev_init();
> +		if (status != 0)
> +			goto step5_fail;
> +
> +		status = sunix_par_lp_init();
> +		if (status != 0)
> +			goto step6_fail;
> +	}

why not doing those initializations on per-device basis, in the
corresponding probe() function ?
> +step7_fail:
> +
> +		pci_unregister_driver(&snx_pci_driver);
> +step6_fail:
> +
> +		sunix_par_ppdev_exit();
> +
> +
> +step5_fail:
> +
> +		sunix_par_parport_exit();
> +
> +
> +step4_fail:
> +
> +		sunix_ser_unregister_ports(&sunix_ser_reg);
> +	}
> +
> +step3_fail:
> +
> +	sunix_ser_unregister_driver(&sunix_ser_reg);
> +
> +
> +step2_fail:
> +
> +	sunix_release_irq();

use devm_*() functions, which automatically releases resource when a
device is deleted, so explicit release isn't needed anymore.

> +static void __exit snx_exit(void)
> +{
> +	if (snx_par_port_total_cnt > 0) {
> +		sunix_par_lp_exit();
> +		sunix_par_ppdev_exit();
> +		sunix_par_parport_exit();
> +	}

Let the cleanup be done by the individual driver's release functions,
and down forget to set .owner correctly - that way, the kernel won't
even allow unloading the module, as long as it's in use. then, you'd
probably don't need much more than just removing unregistering the
drivers here.

> diff --git a/char/snx/snx_serial.c b/char/snx/snx_serial.c
> new file mode 100644
> index 00000000..fdac4c90
> --- /dev/null
> +++ b/char/snx/snx_serial.c
> @@ -0,0 +1,4263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "snx_common.h"
> +#include "driver_extd.h"
> +
> +#define SNX_ioctl_DBG	0

what exactly is that ioctl for ?
or more to the point: why are you introducing a driver specific iotctl ?

> +#define	EEPROM_ACCESS_DELAY_COUNT			100000
> +
> +static DEFINE_SEMAPHORE(ser_port_sem);
> +
> +#define SNX_HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
> +#define sunix_ser_users(state) \
> +((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
> +
> +static struct tty_port snx_service_port;

why has this to be global, instead of in per-device private data ?

<snip>

> +static _INLINE_ void snx_ser_handle_cts_change(
> +	struct snx_ser_port *, unsigned int);

Where's this strange "_INLINE_" coming from ?

<snip>

> +//extern void		snx_ser_change_speed(
> +	//struct snx_ser_state *state, struct SNXTERMIOS *old_termios);

please no dead/commented-out code.

> +//extern int	sunix_ser_interrupt(
> +	//struct sunix_board *, struct sunix_ser_port *first_sp);

same here

> +//extern int      sunix_ser_register_ports(struct snx_ser_driver *drv);
> +//extern void     sunix_ser_unregister_ports(struct snx_ser_driver *drv);
> +//extern int      sunix_ser_register_driver(struct snx_ser_driver *drv);
> +//extern void     sunix_ser_unregister_driver(struct snx_ser_driver *drv);

same here

> +static unsigned char READ_INTERRUPT_VECTOR_BYTE(struct sunix_ser_port *sp)

i'd recommend no caps in function names.

> +		if (var == 0x04) {
> +			vet4 = inb(local_vector + 0xb0);
> +			vet4 <<= 12;
> +		}
> +
> +		data = (vet1 | vet2 | vet3 | vet4);
> +
> +		return data;
> +	}
> +	return 0;
> +}
> +
> +
> +

remove excess newlines

<snip>

> +static int EEPROMWriteData(int targetConfigAddress, int address, int data)

why do you use int instead of void* for addresses ?
oh, and shouldn't it be __iomem ?

<snip>

> +		Error = inb(targetConfigAddress + 0x08) & 0x04;

<snip>

> +static void snx_ser_start(struct tty_struct *tty)
> +{
> +	int line = SNX_SER_DEVNUM(tty);
> +
> +	if (line >= SNX_SER_TOTAL_MAX)
> +		return;
> +
> +	//spin_lock_irqsave(&port->lock, flags);
> +	__snx_ser_start(tty);
> +	//spin_unlock_irqrestore(&port->lock, flags);

why are the spinlock calls commented out ?

<nsip>

> +	tasklet_kill(&info->tlet);

what exactly is the tasklet needed for ?

> +	if (!capable(CAP_SYS_ADMIN)) {
> +		retval = -EPERM;

why this explicit check for CAP_SYS_ADMIN ?

> +		if (change_irq ||

indention mismatch.

> +			change_port ||

why is userland allowed to change irq, port, etc, if that's probed
from pci anyways ?

> +			(new_serial.baud_base != port->uartclk / 16) ||
> +			(close_delay != state->close_delay) ||
> +			(closing_wait != state->closing_wait) ||
> +			(new_serial.xmit_fifo_size != port->fifosize) ||
> +			(((new_flags ^ old_flags) & ~SNX_UPF_USR_MASK) != 0)) {
> +			goto exit;
> +		}
> +
> +		port->flags = ((port->flags & ~SNX_UPF_USR_MASK) |
> +			(new_flags & SNX_UPF_USR_MASK));
> +		port->custom_divisor = new_serial.custom_divisor;
> +		goto check_and_exit;
> +	}

<snip>

> +static int snx_ser_ioctl(struct tty_struct *tty,
> +unsigned int cmd, unsigned long arg)
> +{
<snip>
> +	case TIOCSSERIAL:
> +	{
> +		if (line < SNX_SER_TOTAL_MAX) {
> +			state->port->setserial_flag = SNX_SER_BAUD_SETSERIAL;
> +			ret = snx_ser_set_info(state,
> +				(struct serial_struct *)arg);
> +		}
> +		break;
> +	}
> +
> +
> +	case TCSETS:
> +	{
> +		if (line < SNX_SER_TOTAL_MAX) {
> +			state->port->flags &= ~(SNX_UPF_SPD_HI |
> +				SNX_UPF_SPD_VHI |
> +				SNX_UPF_SPD_SHI |
> +				SNX_UPF_SPD_WARP);
> +			state->port->setserial_flag = SNX_SER_BAUD_NOTSETSER;
> +			snx_ser_update_termios(state);
> +		}
> +		break;
> +	}
> +

Why do you need your own implementation of these tty ioctl()'s ?
The tty subsystem handles them on its own (using the callbacks for hw-
specific operations)

> +	case SNX_SER_DUMP_PORT_INFO:
<snip>
> +	case SNX_SER_DUMP_DRIVER_VER:
<snip>
> +	case SNX_COMM_GET_BOARD_CNT:
<snip>
> +	case SNX_COMM_GET_BOARD_INFO:

is it really necessary to introduce your own driver-specific ioctl() ?
why not putting these things into debugfs or sysfs ?


> +	case SNX_GPIO_GET:
<snip>
> +	case SNX_GPIO_SET:
<snip>
> +	case SNX_GPIO_READ:
<snip>
> +	case SNX_GPIO_WRITE:
<snip>
> +	case SNX_GPIO_SET_DEFAULT:
<snip>
> +	case SNX_GPIO_WRITE_DEFAULT:
<snip>
> +	case SNX_GPIO_GET_INPUT_INVERT:
<snip>
> +	case SNX_GPIO_SET_INPUT_INVERT:


gpio stuff clearly doesn't belong into tty ioctl()s.

that's what the gpio subsystem is there for - this provides the linux
standard api for gpio access.

> +	case SNX_UART_GET_TYPE:

what exactly is this for ?

<snip>
> +		} else {
> +			//pr_err(CE_NOTE, "WARNING : incorrect port
> +			//number (port = %d)!",gb.uart_num);
> +			break;
> +		}
> +
> +			switch (uart_type) {
> +			case 0: // RS-232

yet another indention mismatch.
and please remove dead code.

<snip>

> +	case SNX_UART_SET_TYPE: {

what is this for ?

<snip>

> +	case SNX_UART_SET_ACS:

what is "ACS" ?

> +	{
> +		SNX_DRVR_UART_SET_ACS gb;
> +		struct sunix_board	*sb = NULL;
> +		int ACSstate = 0;
> +		int targetConfigAddress = 0;
> +
> +		memset(&gb, 0, sizeof(SNX_DRVR_UART_SET_ACS));
> +
> +		if (copy_from_user(&gb, (void *)arg,
> +			(sizeof(SNX_DRVR_UART_SET_ACS))))
> +			ret = -EFAULT;
> +		else
> +			ret = 0;
> +
> +		sb = &sunix_board_table[gb.board_id - 1];

do we really need to access global variables here ?

<snip>

> +	if (tty->flags & (1 << TTY_IO_ERROR)) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +		switch (cmd) {
> +		case TIOCMIWAIT:

yet another idention mismatch.

<snip>

> +	if (line < SNX_SER_TOTAL_MAX) {
> +		down(&state->sem);
> +
> +			switch (cmd) {
> +			case TIOCSERGETLSR:
> +			ret = snx_ser_get_lsr_info(state, (unsigned int *)arg);
> +			break;
> +
> +			default:
> +			{
> +				break;
> +			}
> +			}
> +
> +		up(&state->sem);
> +	}

even more indention mismatches.

<snip>

> +static void snx_ser_set_termios(struct tty_struct *tty,
> +struct SNXTERMIOS *old_termios)
> +{
> +	struct snx_ser_state *state = NULL;
> +	unsigned long flags;
> +	unsigned int cflag = tty->termios.c_cflag;
> +	int line = SNX_SER_DEVNUM(tty);
> +
> +	if (line >= SNX_SER_TOTAL_MAX)
> +		return;
> +
> +	state = tty->driver_data;
> +
> +#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))

please no #define's in the middle of a function.

<snip>

> +static void snx_ser_update_timeout(struct snx_ser_port *port,
> +unsigned int cflag, unsigned int baud)
> +{
> +	unsigned int bits;
> +
> +	switch (cflag & CSIZE) {
> +	case CS5:
> +	bits = 7;
> +	break;
> +

more indention mismatches.

<snip>

> +static int snx_ser_open(struct tty_struct *tty, struct file *filp)
> +{
> +	struct snx_ser_driver *drv =
> +	(struct snx_ser_driver *)tty->driver->driver_state;
> +
> +	struct snx_ser_state *state = NULL;
> +	struct tty_port *tport = NULL;
> +
> +	int retval = 0;
> +	int line = SNX_SER_DEVNUM(tty);
> +
> +	if (line < SNX_SER_TOTAL_MAX) {
> +		retval = -ENODEV;
> +
> +		if (line >= SNX_SER_TOTAL_MAX)
> +			goto fail;
> +
> +		state = snx_ser_get(drv, line);
> +
> +		tport = &state->tport;
> +
> +		if (IS_ERR(state)) {
> +			retval = PTR_ERR(state);
> +			goto fail;
> +		}
> +
> +		if (!state)
> +			goto fail;
> +
> +
> +		state->port->suspended = 1;
> +		tty->driver_data = state;
> +
> +		tport->low_latency = (state->port->flags &
> +		SNX_UPF_LOW_LATENCY) ? 1 : 0;
> +
> +		state->info->tty = tty;
> +
> +		tty_port_tty_set(tport, tty);
> +
> +		if (tty_hung_up_p(filp)) {
> +			retval = -EAGAIN;
> +			state->count--;
> +			up(&state->sem);
> +			goto fail;
> +		}
> +
> +		retval = snx_ser_startup(state, 0);
> +
> +		if (retval == 0)
> +			retval = snx_ser_block_til_ready(filp, state);
> +
> +		up(&state->sem);
> +
> +		if (retval == 0 && !(state->info->flags &
> +			SNX_UIF_NORMAL_ACTIVE)) {
> +			state->info->flags |= SNX_UIF_NORMAL_ACTIVE;
> +
> +			snx_ser_update_termios(state);
> +		}
> +
> +		try_module_get(THIS_MODULE);

why this ?

<snip>

> +extern int sunix_ser_register_driver(struct snx_ser_driver *drv)
> +{
> +	struct tty_driver *normal = NULL;
> +	int i;
> +	int ret = 0;
> +
> +	drv->state = kmalloc(sizeof(struct snx_ser_state) * drv->nr,
> +		GFP_KERNEL);
> +
> +	ret = -ENOMEM;
> +
> +	if (!drv->state) {
> +		pr_err("SNX Error: Allocate memory fail !\n\n");
> +		goto out;
> +	}
> +
> +	memset(drv->state, 0, sizeof(struct snx_ser_state) * drv->nr);
> +
> +	for (i = 0; i < drv->nr; i++) {
> +		struct snx_ser_state *state = drv->state + i;
> +		struct tty_port *tport = &state->tport;
> +
> +		tty_port_init(tport);

does that really need to be globally in driver init, instead of in per
port device->open (and use device's private data) ?

<snip>

> +extern void sunix_ser_unregister_ports(struct snx_ser_driver *drv)

why are these 'extern' ?!



--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
